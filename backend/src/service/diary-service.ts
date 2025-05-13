import z from "zod";
import { Timestamp, toDate } from "../domain/timestamp";
import { LatLng } from "../domain/location";
import { LanguageCode } from "../domain/language";
import { FetchNearbyPlaces } from "../infra/map-repository";
import {errAsync, okAsync, ResultAsync} from "neverthrow";
import {
  CreateDBDiaryGenerationJob,
  UpdateDBDiaryGenerationJob,
} from "../infra/diary-generation-job-repository";
import { DBorTx } from "../db/db";
import {createServiceError, ServiceError, StatusCode} from "./error/service-error";
import { CreateDBDiary } from "../infra/diary-repository";
import { GenerateContent } from "../infra/ai-repository";
import { AuthUser } from "../domain/auth";
import { FetchDBUserByUid } from "../infra/user-repository";
import cuid2 from "@paralleldrive/cuid2";
import { dbDiaryForCreate } from "../domain/diary";
import { match } from "ts-pattern";
import { diaryGenerationPrompt } from "../domain/ai";
import {
  dbDiaryGenerationForCreate,
  dbDiaryGenerationJobForUpdateWhenFailed,
  dbDiaryGenerationJobForUpdateWhenSuccess,
} from "../domain/diary-generation-job";

export const Image = z
  .instanceof(File)
  .refine((file) => file.size <= 10 * 1024 * 1024, {
    message: "File size must be less than 10MB",
  });

export const CreateDiaryRequest = z.object({
  locationHistories: z.array(
    z.object({
      latlng: LatLng,
      visitedAt: Timestamp,
    }),
  ),
  languageCode: LanguageCode,
  images: z.array(Image),
});
export type CreateDiaryRequest = z.infer<typeof CreateDiaryRequest>;

export interface CreateDiaryResponse {
  diaryId: string;
  diaryGenerationJobId: string;
}

export type CreateDiary = (
    authUser: AuthUser,
    args: CreateDiaryRequest,
    ) => ResultAsync<CreateDiaryResponse, ServiceError>;

export const createDiary =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchNearbyPlaces: FetchNearbyPlaces,
    createDBDiary: CreateDBDiary,
    createDBDiaryGenerationJob: CreateDBDiaryGenerationJob,
    updateDBDiaryGenerationJob: UpdateDBDiaryGenerationJob,
    generateContent: GenerateContent,
  ): CreateDiary =>
  (
    authUser: AuthUser,
    args: CreateDiaryRequest, //:  =>
  ) =>
    ResultAsync.fromSafePromise(
      (async () => {
        // Check current user
        const dbUser = await fetchDBUserByUid(db)(authUser.uid);
        if (dbUser.isErr()) {
          return errAsync(createServiceError(
            StatusCode.Unauthorized,
            "Unauthorized",
            dbUser.error.message,
          ));
        }

        // create job
        const diaryId = cuid2.createId();
        const dbDiaryGenerationJob = await dbDiaryGenerationForCreate(
          diaryId,
        ).asyncAndThen(createDBDiaryGenerationJob(db));

        if (dbDiaryGenerationJob.isErr()) {
          return errAsync(match(dbDiaryGenerationJob.error)
            .with({ __brand: "DBError" }, (e) =>
              createServiceError(
                match(e.code)
                  .with("unknown", () => StatusCode.InternalServerError)
                  .exhaustive(),
                e.message,
              ),
            )
            .exhaustive());
        }

        // Call Gemini API
        const callAI = async () => {
          const places = await ResultAsync.combine(
            args.locationHistories.map((locationHistory) =>
              fetchNearbyPlaces({
                languageCode: args.languageCode,
                latlng: locationHistory.latlng,
              }).map((places) => ({
                visitedAt: toDate(locationHistory.visitedAt),
                places,
              })),
            ),
          );

          if (places.isErr()) {
            dbDiaryGenerationJobForUpdateWhenFailed(
              dbDiaryGenerationJob.value.id,
              "Failed to fetch nearby places",
            ).asyncAndThen(updateDBDiaryGenerationJob(db));
            return;
          }

          const res = await generateContent(
            diaryGenerationPrompt(places.value, args.languageCode, ""),
            args.images,
          );

          if (res.isErr()) {
            dbDiaryGenerationJobForUpdateWhenFailed(
              dbDiaryGenerationJob.value.id,
              "Failed to generate content",
            ).asyncAndThen(updateDBDiaryGenerationJob(db));
            return;
          }

          const now = new Date();
          const diary = await dbDiaryForCreate(
            dbUser.value.id,
            res.value.text,
            {
              year: now.getFullYear(),
              month: now.getMonth() + 1,
              day: now.getDate(),
            },
          ).asyncAndThen(createDBDiary(db));

          if (diary.isErr()) {
            dbDiaryGenerationJobForUpdateWhenFailed(
              dbDiaryGenerationJob.value.id,
              "Failed to create diary",
            ).asyncAndThen(updateDBDiaryGenerationJob(db));
            return;
          }

          const job = await dbDiaryGenerationJobForUpdateWhenSuccess(
            dbDiaryGenerationJob.value.id,
          ).asyncAndThen(updateDBDiaryGenerationJob(db));

          if (job.isErr()) {
            dbDiaryGenerationJobForUpdateWhenFailed(
              dbDiaryGenerationJob.value.id,
              "Failed to update diary generation job",
            ).asyncAndThen(updateDBDiaryGenerationJob(db));
            return;
          }

          console.log("Diary generation completed:", diary.value, job.value);
        };

        // AI のレスポンスはポーリングで取得する
        callAI();

        return okAsync({
            diaryId,
            diaryGenerationJobId: dbDiaryGenerationJob.value.id,
        });
      })(),
    ).andThen(result => result);
