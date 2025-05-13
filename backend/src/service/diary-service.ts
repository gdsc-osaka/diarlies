import z from "zod";
import { Timestamp, toDate } from "../domain/timestamp";
import { LatLng } from "../domain/location";
import { LanguageCode } from "../domain/language";
import { FetchNearbyPlaces } from "../infra/map-repository";
import { errAsync, ResultAsync } from "neverthrow";
import { DBorTx } from "../db/db";
import {
  createServiceError,
  ServiceError,
  StatusCode,
} from "./error/service-error";
import { CreateDBDiary } from "../infra/diary-repository";
import { GenerateContent } from "../infra/ai-repository";
import { AuthUser } from "../domain/auth";
import { FetchDBUserByUid } from "../infra/user-repository";
import { convertToDiary, dbDiaryForCreate, Diary } from "../domain/diary";
import { diaryGenerationPrompt } from "../domain/ai";

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

export type CreateDiary = (
  authUser: AuthUser,
  args: CreateDiaryRequest,
) => ResultAsync<Diary, ServiceError>;

export const createDiary =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchNearbyPlaces: FetchNearbyPlaces,
    createDBDiary: CreateDBDiary,
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
          return errAsync(
            createServiceError(
              StatusCode.Unauthorized,
              "Unauthorized",
              dbUser.error.message,
            ),
          );
        }

        // Call Gemini API
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
          return errAsync(
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to fetch nearby places",
              places.error.message,
            ),
          );
        }

        const res = await generateContent(
          diaryGenerationPrompt(places.value, args.languageCode, ""),
          args.images,
        );

        if (res.isErr()) {
          return errAsync(
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to generate content",
              res.error.message,
            ),
          );
        }

        const now = new Date();
        const diary = await dbDiaryForCreate(dbUser.value.id, res.value.text, {
          year: now.getFullYear(),
          month: now.getMonth() + 1,
          day: now.getDate(),
        }).asyncAndThen(createDBDiary(db));

        if (diary.isErr()) {
          return errAsync(
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to create diary",
              diary.error.message,
            ),
          );
        }

        console.log("Diary generation completed:", diary.value);

        return convertToDiary(diary.value);
      })(),
    ).andThen((result) => result);
