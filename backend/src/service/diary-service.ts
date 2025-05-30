import z from "zod";
import { LanguageCode } from "../domain/language";
import { FetchNearbyPlaces } from "../infra/map-repo";
import { okAsync, Result, ResultAsync } from "neverthrow";
import { DBorTx } from "../db/db";
import {
  createServiceError,
  ServiceError,
  StatusCode,
} from "./error/service-error";
import {
  CreateDBDiary,
  DeleteDBDiary,
  FetchDBDiariesByDuration,
  FetchDBDiaryByDate,
  FetchDBDiaryById,
} from "../infra/diary-repo";
import { GenerateContent } from "../infra/ai-repo";
import { AuthUser } from "../domain/auth";
import {
  convertToDiary,
  convertToDiaryWithUser,
  dbDiaryForCreate,
  Diary,
  DiaryWithUser,
  isDBDiaryOwnedByUser,
} from "../domain/diary";
import { diaryGenerationPrompt, trimSystemPrompt } from "../domain/ai";
import { match } from "ts-pattern";
import { GetDownloadUrl, UploadFile } from "../infra/storage-repo";
import { fileData, filePath, thumbnailStorageBucket } from "../domain/storage";
import { id } from "../shared/func";
import { SendDiscordMessage } from "../infra/discord-repo";
import { FetchDBUserByUid } from "../infra/user-repo";
import { DBInternalError } from "../infra/error/db-error";
import { DBUserNotFoundError } from "../infra/user-repo.error";
import {
  DBDiaryAlreadyExistsError,
  DBDiaryNotFoundError,
} from "../infra/diary-repo.error";
import { AIError } from "../infra/ai-repo.error";
import { MapError } from "../infra/map-repo.error";
import { StorageError } from "../infra/storage-repo.error";
import { DiscordError } from "../infra/discord-repo.error";

export const Image = z
  .instanceof(File)
  .refine((file) => file.size <= 10 * 1024 * 1024, {
    message: "File size must be less than 10MB",
  });
export const CreateDiaryRequest = z.object({
  locationHistories: z.array(
    z.object({
      lat: z.number(),
      lng: z.number(),
      visitedAt: z.string(),
    }),
  ),
  languageCode: LanguageCode,
  images: z.array(Image),
  memo: z.string().optional().nullable(),
});
export type CreateDiaryRequest = z.infer<typeof CreateDiaryRequest>;

export type CreateDiary = (
  authUser: AuthUser,
  args: CreateDiaryRequest,
) => ResultAsync<
  Diary,
  | DBInternalError
  | DBUserNotFoundError
  | DBDiaryAlreadyExistsError
  | AIError
  | MapError
  | StorageError
>;

export const createDiary =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchNearbyPlaces: FetchNearbyPlaces,
    createDBDiary: CreateDBDiary,
    generateContent: GenerateContent,
    uploadFile: UploadFile,
  ): CreateDiary =>
  (authUser: AuthUser, args: CreateDiaryRequest) =>
    ResultAsync.combine([
      // check user existence
      fetchDBUserByUid(db)(authUser.uid),
      // fetch nearby places
      ResultAsync.combine(
        args.locationHistories.map((locationHistory) =>
          fetchNearbyPlaces({
            languageCode: args.languageCode,
            lat: locationHistory.lat,
            lng: locationHistory.lng,
          }).map((places) => ({
            visitedAt: new Date(locationHistory.visitedAt),
            places,
          })),
        ),
        // generate content
      ).andThen((places) =>
        generateContent(
          diaryGenerationPrompt(
            places,
            args.languageCode,
            args.memo ?? undefined,
          ),
          args.images,
        ).andThen(trimSystemPrompt),
      ),
    ])
      // insert diary to db
      .andThen(([dbUser, generated]) =>
        dbDiaryForCreate(dbUser.id, generated)
          .asyncAndThen(createDBDiary(db))
          .map((diary) => ({ dbUser, diary, generated })),
      )
      // upload thumbnail to storage
      .andThen(({ dbUser, diary, generated }) =>
        (generated.image
          ? uploadFile(thumbnailStorageBucket())(
              fileData(dbUser, diary.thumbnailPath, generated.image),
            )
          : okAsync(undefined)
        ).map((thumbnailUrl) => ({ diary, thumbnailUrl })),
      )
      // convert to Diary
      .andThen(({ diary, thumbnailUrl }) =>
        convertToDiary(diary, thumbnailUrl),
      );

export type FetchDiaryByDate = (
  authUser: AuthUser,
  date: Date,
) => ResultAsync<Diary, ServiceError>;

export const fetchDiaryByDate =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchDBDiaryByDate: FetchDBDiaryByDate,
    getDownloadUrl: GetDownloadUrl,
  ): FetchDiaryByDate =>
  (authUser: AuthUser, date: Date) =>
    fetchDBUserByUid(db)(authUser.uid)
      .mapErr((err) =>
        match(err)
          .with(DBUserNotFoundError.is, () =>
            createServiceError(
              StatusCode.Unauthorized,
              "User not found",
              err.message,
            ),
          )
          .with(DBInternalError.is, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to find user",
              e.message,
            ),
          )
          .exhaustive(),
      )
      .andThen((dbUser) =>
        fetchDBDiaryByDate(db)(dbUser.id, date).andThen((dbDiary) =>
          getDownloadUrl(thumbnailStorageBucket())(
            filePath(dbUser, dbDiary.thumbnailPath),
          ).map((thumbnailUrl) => ({ dbDiary, thumbnailUrl })),
        ),
      )
      .andThen(({ dbDiary, thumbnailUrl }) =>
        convertToDiary(dbDiary, thumbnailUrl),
      )
      .mapErr((err) =>
        match(err)
          .with(DBDiaryNotFoundError.is, (e) =>
            createServiceError(
              StatusCode.NotFound,
              "Diary not found",
              e.message,
            ),
          )
          .with(DBInternalError.is, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to fetch diary",
              e.message,
            ),
          )
          .with(StorageError.is, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to fetch thumbnail",
              e.message,
            ),
          )
          .with({ __brand: "ServiceError" }, id)
          .exhaustive(),
      );

export type FetchDiariesByDuration = (
  authUser: AuthUser,
  startDate: Date,
  endDate: Date,
) => ResultAsync<DiaryWithUser[], ServiceError>;

export const fetchDiariesByDuration =
  (
    db: DBorTx,
    fetchDBDiariesByDuration: FetchDBDiariesByDuration,
    getDownloadUrl: GetDownloadUrl,
  ): FetchDiariesByDuration =>
  // TODO: AuthUser がフォローしているユーザーの Diary を取得するようにする
  (_: AuthUser, startDate, endDate) =>
    fetchDBDiariesByDuration(db)(startDate, endDate)
      .andThen((dbDiaries) =>
        ResultAsync.combine(
          dbDiaries.map((dbDiary) =>
            getDownloadUrl(thumbnailStorageBucket())(
              filePath(dbDiary.user, dbDiary.thumbnailPath),
            ).map((thumbnailUrl) => ({ dbDiary, thumbnailUrl })),
          ),
        ),
      )
      .andThen((diaries) =>
        Result.combine(
          diaries.map(({ dbDiary, thumbnailUrl }) =>
            convertToDiaryWithUser(dbDiary, thumbnailUrl),
          ),
        ),
      )
      .mapErr((err) =>
        match(err)
          .with(DBInternalError.is, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to fetch diary",
              e.message,
            ),
          )
          .with(StorageError.is, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to fetch thumbnail",
              e.message,
            ),
          )
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
          .with(DBUserNotFoundError.is, () =>
            createServiceError(
              StatusCode.Unauthorized,
              "User not found",
              err.message,
            ),
          )
          .with(DBInternalError.is, (e) =>
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
          .with({ __brand: "ServiceError" }, id)
          .with(DBDiaryNotFoundError.is, (e) =>
            createServiceError(
              StatusCode.NotFound,
              "Diary not found",
              e.message,
            ),
          )
          .with(DBInternalError.is, (e) =>
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

export type ReportInappropriateDiary = (
  authUser: AuthUser,
  diaryId: string,
  reason: string,
) => ResultAsync<void, ServiceError>;

// check if diary exists, check if diary belongs to user, send discord message
export const reportInappropriateDiary =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    fetchDBDiaryById: FetchDBDiaryById,
    sendDiscordMessage: SendDiscordMessage,
  ): ReportInappropriateDiary =>
  (authUser: AuthUser, diaryId: string, reason: string) =>
    fetchDBUserByUid(db)(authUser.uid)
      .mapErr((err) =>
        match(err)
          .with(DBUserNotFoundError.is, () =>
            createServiceError(
              StatusCode.Unauthorized,
              "User not found",
              err.message,
            ),
          )
          .with(DBInternalError.is, (e) =>
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
      .andThen(() =>
        sendDiscordMessage(
          `Inappropriate diary reported. Diary ID: ${diaryId}. Reason: ${reason}`,
        ),
      )
      .mapErr((err) =>
        match(err)
          .with({ __brand: "ServiceError" }, id)
          .with(DBDiaryNotFoundError.is, (e) =>
            createServiceError(
              StatusCode.NotFound,
              "Diary not found",
              e.message,
            ),
          )
          .with(DBInternalError.is, (e) =>
            createServiceError(
              StatusCode.InternalServerError,
              "Failed to report diary",
              e.message,
            ),
          )
          .with("diary_not_owned_by_user", () =>
            createServiceError(
              StatusCode.Forbidden,
              "The user does not have permission to report this diary",
              "permission_denied",
            ),
          )
          .with(DiscordError.is, () =>
            createServiceError(
              StatusCode.InternalServerError,
              `Failed to send discord message.`,
            ),
          )
          .exhaustive(),
      );
