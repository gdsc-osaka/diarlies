import { CreateDiary } from "../service/diary-service";
import { match } from "ts-pattern";
import { DBInternalError } from "../infra/error/db-error";
import { createServiceError, StatusCode } from "../service/error/service-error";
import { DBUserNotFoundError } from "../infra/user-repo.error";
import { DBDiaryAlreadyExistsError } from "../infra/diary-repo.error";
import { AIError } from "../infra/ai-repo.error";
import { MapError } from "../infra/map-repo.error";
import { StorageError } from "../infra/storage-repo.error";

export const createDiaryController = (createDiary: ReturnType<CreateDiary>) =>
  createDiary.mapErr((err) =>
    match(err)
      .with(DBInternalError.is, (e) =>
        createServiceError(StatusCode.InternalServerError, e.message),
      )
      .with(DBUserNotFoundError.is, (e) =>
        createServiceError(StatusCode.NotFound, e.message, "user-not-found", {
          uid: e.extra?.userId,
        }),
      )
      .with(DBDiaryAlreadyExistsError.is, (e) =>
        createServiceError(
          StatusCode.BadRequest,
          e.message,
          "diary-already-exists",
          { diaryDate: e.extra?.diaryDate, userId: e.extra?.userId },
        ),
      )
      .with(AIError.is, (e) =>
        createServiceError(
          StatusCode.InternalServerError,
          e.message,
          "ai-error",
          { extra: e.extra },
        ),
      )
      .with(MapError.is, (e) =>
        createServiceError(
          StatusCode.InternalServerError,
          e.message,
          "map-error",
          { extra: e.extra },
        ),
      )
      .with(StorageError.is, (e) =>
        createServiceError(
          StatusCode.InternalServerError,
          e.message,
          "storage-error",
          { extra: e.extra },
        ),
      )
      .exhaustive(),
  );
