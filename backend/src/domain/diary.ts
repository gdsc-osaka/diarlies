import z from "zod";
import { Timestamp, toTimestamp } from "./timestamp";
import { Day } from "./day";
import { diaries } from "../db/schema/diaries";
import { ok, Result } from "neverthrow";

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
    diaryDate: new Date(diaryDate.year, diaryDate.month - 1, diaryDate.day),
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
      day: dbDiary.diaryDate.getDate() + 1,
    },
    createdAt,
    updatedAt,
  }));
};
