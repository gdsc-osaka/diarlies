import z from "zod";
import { Timestamp } from "../domain/timestamp";
import { LatLng } from "../domain/location";
import { LanguageCode } from "../domain/language";
import { FetchNearbyPlaces } from "../infra/map-repository";
import { ResultAsync } from "neverthrow";
import {
  CreateDBDiaryGenerationJob,
  UpdateDBDiaryGenerationJob,
} from "../infra/diary-generation-job-repository";
import { createDBDiaryForCreate } from "../domain/diary";
import cuid2 from "@paralleldrive/cuid2";
import { DBorTx } from "../db/db";
import {
  createServiceError,
  ServiceError,
  StatusCode,
} from "./error/service-error";
import { match } from "ts-pattern";

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

export const createDiary =
  (
    db: DBorTx,
    fetchNearbyPlaces: FetchNearbyPlaces,
    createDBDiaryGenerationJob: CreateDBDiaryGenerationJob,
    updateDBDiaryGenerationJob: UpdateDBDiaryGenerationJob,
  ) =>
  (args: CreateDiaryRequest): ResultAsync<CreateDiaryResponse, ServiceError> =>
    ResultAsync.combine(
      args.locationHistories.map((locationHistory) =>
        fetchNearbyPlaces({
          languageCode: args.languageCode,
          latlng: locationHistory.latlng,
        }).map((places) => ({
          visitedAt: locationHistory.visitedAt,
          places,
        })),
      ),
    )
      .map((places) => ({
        places,
        diaryId: cuid2.createId(),
      }))
      .andThen((context) =>
        createDBDiaryForCreate(context.diaryId).map((job) => ({
          ...context,
          job,
        })),
      )
      .andThen((context) =>
        createDBDiaryGenerationJob(db)(context.job).map((job) => ({
          ...context,
          job,
        })),
      )
      .andTee(() => {
        // TODO: Call Gemini API
      })
      // 結果を整形
      .map((context) => ({
        diaryId: context.diaryId,
        diaryGenerationJobId: context.job.id,
      }))
      .mapErr((err) =>
        match(err)
          .with({ __brand: "DBError" }, (e) =>
            createServiceError(
              match(e.code)
                .with("unknown", () => StatusCode.InternalServerError)
                .exhaustive(),
              e.message,
            ),
          )
          .with({ __brand: "MapError" }, (e) =>
            createServiceError(
              match(e.code)
                .with("unknown", () => StatusCode.InternalServerError)
                .exhaustive(),
              e.message,
            ),
          )
          .exhaustive(),
      );
