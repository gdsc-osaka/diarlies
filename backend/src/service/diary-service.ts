import z from "zod";
import { Timestamp, toDate } from "../domain/timestamp";
import { LanguageCode } from "../domain/language";
import { FetchNearbyPlaces } from "../infra/map-repository";
import { errAsync, ResultAsync } from "neverthrow";
import { DBorTx } from "../db/db";
import {
  createServiceError,
  ServiceError,
  StatusCode,
} from "./error/service-error";
import {
  CreateDBDiary,
  DeleteDBDiary,
  FetchDBDiaryByDate,
  FetchDBDiaryById,
} from "../infra/diary-repository";
import { GenerateContent } from "../infra/ai-repository";
import { AuthUser } from "../domain/auth";
import { FetchDBUserByUid } from "../infra/user-repository";
import {
  convertToDiary,
  dbDiaryForCreate,
  Diary,
  isDBDiaryOwnedByUser,
} from "../domain/diary";
import { diaryGenerationPrompt } from "../domain/ai";
import { match } from "ts-pattern";

export const Image = z
  .instanceof(File)
  .refine((file) => file.size <= 10 * 1024 * 1024, {
    message: "File size must be less than 10MB",
  });
export const CreateDiaryRequest = z.object({
  locationHistories: z.array(
    z.object({
      lag: z.number(),
      lng: z.number(),
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
              "User not found",
              dbUser.error.message,
            ),
          );
        }

        // Call Gemini API
        const places = await ResultAsync.combine(
          args.locationHistories.map((locationHistory) =>
            fetchNearbyPlaces({
              languageCode: args.languageCode,
              lat: locationHistory.lag,
              lng: locationHistory.lng,
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

export type FetchDiaryByDate = (
  authUser: AuthUser,
  date: Date,
) => ResultAsync<Diary, ServiceError>;

export const fetchDiaryByDate =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchDBDiaryByDate: FetchDBDiaryByDate,
  ): FetchDiaryByDate =>
  (authUser: AuthUser, date: Date) =>
    fetchDBUserByUid(db)(authUser.uid)
      .mapErr((err) =>
        match(err)
          .with(
            {
              __brand: "DBError",
              code: "not-found",
            },
            () =>
              createServiceError(
                StatusCode.Unauthorized,
                "User not found",
                err.message,
              ),
          )
          .with(
            {
              __brand: "DBError",
              code: "unknown",
            },
            (e) =>
              createServiceError(
                StatusCode.InternalServerError,
                "Failed to find user",
                e.message,
              ),
          )
          .exhaustive(),
      )
      .andThen((dbUser) => fetchDBDiaryByDate(db)(dbUser.id, date))
      .andThen(convertToDiary)
      .mapErr((err) =>
        match(err)
          .with(
            {
              __brand: "DBError",
              code: "not-found",
            },
            (e) =>
              createServiceError(
                StatusCode.NotFound,
                "Diary not found",
                e.message,
              ),
          )
          .with(
            {
              __brand: "DBError",
              code: "unknown",
            },
            (e) =>
              createServiceError(
                StatusCode.InternalServerError,
                "Failed to fetch diary",
                e.message,
              ),
          )
          .with({ __brand: "ServiceError" }, (e) => e)
          .exhaustive(),
      );

// delete
export type DeleteDiary = (
  authUser: AuthUser,
  diaryId: string,
) => ResultAsync<Diary, ServiceError>;

// fetch dbUser, fetch diary by id, check if diary belongs to user, delete diary.
export const deleteDiary =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchDBDiaryById: FetchDBDiaryById,
    deleteDBDiary: DeleteDBDiary,
  ): DeleteDiary =>
  (authUser: AuthUser, diaryId: string) =>
    fetchDBUserByUid(db)(authUser.uid)
      .mapErr((err) =>
        match(err)
          .with({ __brand: "DBError", code: "not-found" }, () =>
            createServiceError(
              StatusCode.Unauthorized,
              "User not found",
              err.message,
            ),
          )
          .with({ __brand: "DBError", code: "unknown" }, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to find user",
              e.message,
            ),
          )
          .exhaustive(),
      )
      .andThen((dbUser) =>
        fetchDBDiaryById(db)(diaryId).andThen((dbDiary) =>
          isDBDiaryOwnedByUser(dbDiary, dbUser),
        ),
      )
      .andThen(() => deleteDBDiary(db)(diaryId))
      .andThen(convertToDiary)
      .mapErr((err) =>
        match(err)
          .with({ __brand: "ServiceError" }, (e) => e)
          .with({ __brand: "DBError", code: "not-found" }, (e) =>
            createServiceError(
              StatusCode.NotFound,
              "Diary not found",
              e.message,
            ),
          )
          .with({ __brand: "DBError", code: "unknown" }, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to delete diary",
              e.message,
            ),
          )
          .with("diary_not_owned_by_user", () =>
            createServiceError(
              StatusCode.Forbidden,
              "The user does not have permission to delete this diary",
              "permission_denied",
            ),
          )
          .exhaustive(),
      );
