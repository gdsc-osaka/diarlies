import type { DBorTx } from "../db/db";
import {
  DBDiaryGenerationJob,
  DBDiaryGenerationJobForCreate,
  DBDiaryGenerationJobForUpdate,
} from "../domain/diary";
import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { createDBError, DBError, handleDBError } from "./error/db-error";
import { infraLogger } from "../logger";
import { diaryGenerationJobs } from "../db/schema/diary-generation-jobs";
import { eq } from "drizzle-orm";

export type CreateDBDiaryGenerationJob = (
  db: DBorTx,
) => (
  job: DBDiaryGenerationJobForCreate,
) => ResultAsync<DBDiaryGenerationJob, DBError<"unknown">>;

export const createDBDiaryGenerationJob: CreateDBDiaryGenerationJob =
  (db) => (job) =>
    ResultAsync.fromPromise(
      db.insert(diaryGenerationJobs).values(job).returning().execute(),
      handleDBError,
    )
      .andThen((records) =>
        records.length > 0
          ? okAsync(records[0])
          : errAsync(
              createDBError(
                "unknown",
                `Diary with uid ${job.id} not created`,
                undefined,
              ),
            ),
      )
      .orTee(infraLogger.error);

export type UpdateDBDiaryGenerationJob = (
  db: DBorTx,
) => (
  job: DBDiaryGenerationJobForUpdate,
) => ResultAsync<DBDiaryGenerationJob, DBError<"unknown">>;

export const updateDBDiaryGenerationJob: UpdateDBDiaryGenerationJob =
  (db) => (diaryJob) =>
    ResultAsync.fromPromise(
      db
        .update(diaryGenerationJobs)
        .set(diaryJob)
        .where(eq(diaryGenerationJobs.id, diaryJob.id))
        .returning()
        .execute(),
      handleDBError,
    )
      .andThen((records) =>
        records.length > 0
          ? okAsync(records[0])
          : errAsync(
              createDBError(
                "unknown",
                `Diary with uid ${diaryJob.id} not updated`,
                undefined,
              ),
            ),
      )
      .orTee(infraLogger.error);
