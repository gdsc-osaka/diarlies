import z from "zod";
import { Timestamp } from "./timestamp";
import { Date } from "./date";
import { diaries } from "../db/schema/diaries";
import { ok, Result } from "neverthrow";

export const Diary = z
  .object({
    id: z.string(),
    content: z.string(),
    diaryDate: Date,
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
  diaryDate: Date,
): Result<DBDiaryForCreate, never> => {
  return ok({
    userId,
    content,
    diaryDate: `${diaryDate.year}-${diaryDate.month}-${diaryDate.day}`,
  });
};
