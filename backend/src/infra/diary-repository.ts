import type { DBorTx } from "../db/db";
import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { createDBError, DBError, handleDBError } from "./error/db-error";
import { DBDiary, DBDiaryForCreate, DBDiaryWithDBUser } from "../domain/diary";
import { diaries } from "../db/schema/diaries";
import { infraLogger } from "../logger";
import { and, eq } from "drizzle-orm";

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

export type FetchDBDiaryById = (
  db: DBorTx,
) => (
  diaryId: string,
) => ResultAsync<DBDiary, DBError<"unknown" | "not-found">>;

export const fetchDBDiaryById: FetchDBDiaryById = (db) => (diaryId) =>
  ResultAsync.fromPromise(
    db.select().from(diaries).where(eq(diaries.id, diaryId)).limit(1).execute(),
    handleDBError,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            createDBError(
              "not-found",
              `Diary with id ${diaryId} not found`,
              undefined,
            ),
          ),
    )
    .orTee(infraLogger.error);

export type FetchDBDiaryByDate = (
  db: DBorTx,
) => (
  userId: string,
  date: Date,
) => ResultAsync<DBDiary, DBError<"unknown" | "not-found">>;

export const fetchDBDiaryByDate: FetchDBDiaryByDate = (db) => (userId, date) =>
  ResultAsync.fromPromise(
    db
      .select()
      .from(diaries)
      .where(and(eq(diaries.userId, userId), eq(diaries.diaryDate, date)))
      .limit(1)
      .execute(),
    handleDBError,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            createDBError(
              "not-found",
              `Diary with date ${date} not found`,
              undefined,
            ),
          ),
    )
    .orTee(infraLogger.error);

export type FetchDBDiariesByDuration = (
  db: DBorTx,
) => (
  startDate: Date,
  endOrEqualDate: Date,
) => ResultAsync<DBDiaryWithDBUser[], DBError<"unknown">>;

export const fetchDBDiariesByDuration: FetchDBDiariesByDuration =
  (db) => (startDate, endDate) =>
    ResultAsync.fromPromise(
      db.query.users.findMany({
        where: (users, { eq }) => eq(users.visibility, "public"),
        with: {
          diaries: {
            orderBy: (diaries, { desc }) => [desc(diaries.diaryDate)],
            where: (diaries, { and, lte, gte }) =>
              and(
                lte(diaries.diaryDate, endDate),
                gte(diaries.diaryDate, startDate),
              ),
          },
        },
      }),
      handleDBError,
    )
      .map((records) =>
        records
          .map(({ diaries, ...user }) =>
            diaries.map((diary) => ({ ...diary, user })),
          )
          .flat(),
      )
      .orTee(infraLogger.error);

export type DeleteDBDiary = (
  db: DBorTx,
) => (
  diaryId: string,
) => ResultAsync<DBDiary, DBError<"unknown" | "not-found">>;

export const deleteDBDiary: DeleteDBDiary = (db) => (diaryId) =>
  ResultAsync.fromPromise(
    db.delete(diaries).where(eq(diaries.id, diaryId)).returning().execute(),
    handleDBError,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            createDBError(
              "not-found",
              `Diary with id ${diaryId} not found`,
              undefined,
            ),
          ),
    )
    .orTee(infraLogger.error);
