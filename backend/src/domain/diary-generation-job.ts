import { diaryGenerationJobs } from "../db/schema/diary-generation-jobs";
import { ok, Result } from "neverthrow";

export type DBDiaryGenerationJob = typeof diaryGenerationJobs.$inferSelect;
export type DBDiaryGenerationJobForCreate =
  typeof diaryGenerationJobs.$inferInsert;
export type DBDiaryGenerationJobForUpdate = Pick<DBDiaryGenerationJob, "id"> &
  Partial<DBDiaryGenerationJob>;

export const dbDiaryGenerationForCreate = (
  diaryId: string,
): Result<DBDiaryGenerationJobForCreate, never> => {
  return ok({
    diaryId,
    status: "PROCESSING",
  });
};

export const dbDiaryGenerationJobForUpdateWhenFailed = (
  id: string,
  message: string,
): Result<DBDiaryGenerationJobForUpdate, never> => {
  return ok({
    id,
    status: "FAILED",
    errorMessage: message,
  });
};

export const dbDiaryGenerationJobForUpdateWhenSuccess = (
  id: string,
): Result<DBDiaryGenerationJobForUpdate, never> => {
  return ok({
    id,
    status: "COMPLETED",
  });
};
