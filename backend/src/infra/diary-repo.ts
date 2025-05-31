import type { DBorTx } from "../db/db";
import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { DBInternalError } from "./error/db-error";
import { DBDiary, DBDiaryForCreate, DBDiaryWithDBUser } from "../domain/diary";
import { diaries } from "../db/schema/diaries";
import { infraLogger } from "../logger";
import { and, eq } from "drizzle-orm";
import {
  DBDiaryAlreadyExistsError,
  DBDiaryNotFoundError,
} from "./diary-repo.error";

export type CreateDBDiary = (
  db: DBorTx,
) => (
  diary: DBDiaryForCreate,
) => ResultAsync<DBDiary, DBInternalError | DBDiaryAlreadyExistsError>;

export const createDBDiary: CreateDBDiary = (db) => (diary) =>
  ResultAsync.fromPromise(
    db.insert(diaries).values(diary).returning().execute(),
    DBInternalError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBDiaryAlreadyExistsError("Diary already exists", {
              extra: { diaryDate: diary.diaryDate, userId: diary.userId },
            }),
          ),
    )
    .andTee(infraLogger("createDBDiary").info)
    .orTee(infraLogger("createDBDiary").error);

export type FetchDBDiaryById = (
  db: DBorTx,
) => (
  diaryId: string,
) => ResultAsync<DBDiary, DBInternalError | DBDiaryNotFoundError>;

export const fetchDBDiaryById: FetchDBDiaryById = (db) => (diaryId) =>
  ResultAsync.fromPromise(
    db.select().from(diaries).where(eq(diaries.id, diaryId)).limit(1).execute(),
    DBInternalError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBDiaryNotFoundError(`Diary not found`, { extra: { diaryId } }),
          ),
    )
    .orTee(infraLogger("fetchDBDiaryById").error);

export type FetchDBDiaryByDate = (
  db: DBorTx,
) => (
  userId: string,
  date: Date,
) => ResultAsync<DBDiary, DBInternalError | DBDiaryNotFoundError>;

export const fetchDBDiaryByDate: FetchDBDiaryByDate = (db) => (userId, date) =>
  ResultAsync.fromPromise(
    db
      .select()
      .from(diaries)
      .where(and(eq(diaries.userId, userId), eq(diaries.diaryDate, date)))
      .limit(1)
      .execute(),
    DBInternalError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBDiaryNotFoundError("Diary not found", {
              extra: { userId, date },
            }),
          ),
    )
    .orTee(infraLogger("fetchDBDiaryByDate").error);

export type FetchDBDiariesByDuration = (
  db: DBorTx,
) => (
  startDate: Date,
  endOrEqualDate: Date,
) => ResultAsync<DBDiaryWithDBUser[], DBInternalError>;

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
      DBInternalError.handle,
    )
      .map((records) =>
        records
          .map(({ diaries, ...user }) =>
            diaries.map((diary) => ({ ...diary, user })),
          )
          .flat(),
      )
      .orTee(infraLogger("fetchDBDiariesByDuration").error);

export type DeleteDBDiary = (
  db: DBorTx,
) => (
  diaryId: string,
) => ResultAsync<DBDiary, DBInternalError | DBDiaryNotFoundError>;

export const deleteDBDiary: DeleteDBDiary = (db) => (diaryId) =>
  ResultAsync.fromPromise(
    db.delete(diaries).where(eq(diaries.id, diaryId)).returning().execute(),
    DBInternalError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBDiaryNotFoundError("Diary not found", {
              extra: { diaryId },
            }),
          ),
    )
    .andTee(infraLogger("deleteDBDiary").info)
    .orTee(infraLogger("deleteDBDiary").error);
