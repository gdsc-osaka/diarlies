import z from "zod";
import { Timestamp, toTimestamp } from "./timestamp";
import { Day } from "./day";
import { diaries } from "../db/schema/diaries";
import { err, ok, Result } from "neverthrow";
import { DBUser } from "./user";

export const Diary = z
  .object({
    id: z.string(),
    content: z.string(),
    diaryDate: Day,
    createdAt: Timestamp,
    updatedAt: Timestamp,
  })
  .openapi({ ref: "Diary" });
export type Diary = z.infer<typeof Diary>;

export type DBDiary = typeof diaries.$inferSelect;
export type DBDiaryForCreate = typeof diaries.$inferInsert;

export const dbDiaryForCreate = (
  userId: string,
  content: string,
  diaryDate: Day,
): Result<DBDiaryForCreate, never> => {
  return ok({
    userId,
    content,
    diaryDate: new Date(diaryDate.year, diaryDate.month - 1, diaryDate.day + 1),
  });
};

export const convertToDiary = (dbDiary: DBDiary): Result<Diary, never> => {
  return Result.combine([
    toTimestamp(dbDiary.createdAt),
    toTimestamp(dbDiary.updatedAt),
  ]).map(([createdAt, updatedAt]) => ({
    id: dbDiary.id,
    content: dbDiary.content,
    diaryDate: {
      year: dbDiary.diaryDate.getFullYear(),
      month: dbDiary.diaryDate.getMonth() + 1,
      day: dbDiary.diaryDate.getDate(),
    },
    createdAt,
    updatedAt,
  }));
};

export const isDBDiaryOwnedByUser = (
  dbDiary: DBDiary,
  user: DBUser,
): Result<true, "diary_not_owned_by_user"> => {
  if (dbDiary.userId === user.id) {
    return ok(true);
  } else {
    return err("diary_not_owned_by_user");
  }
};
