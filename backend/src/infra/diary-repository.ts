import type { DBorTx } from "../db/db";
import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { createDBError, DBError, handleDBError } from "./error/db-error";
import { DBDiary, DBDiaryForCreate } from "../domain/diary";
import { diaries } from "../db/schema/diaries";
import { infraLogger } from "../logger";

export type CreateDBDiary = (
  db: DBorTx,
) => (user: DBDiaryForCreate) => ResultAsync<DBDiary, DBError<"unknown">>;

export const createDBDiary: CreateDBDiary = (db) => (diary) =>
  ResultAsync.fromPromise(
    db.insert(diaries).values(diary).returning().execute(),
    handleDBError,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            createDBError(
              "unknown",
              `Diary with uid ${diary.id} not created`,
              undefined,
            ),
          ),
    )
    .orTee(infraLogger.error);
