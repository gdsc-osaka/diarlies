import z from "zod";
import { Timestamp } from "./timestamp";
import { Date } from "./date";
import { diaries } from "../db/schema/diaries";
import { diaryGenerationJobs } from "../db/schema/diary-generation-jobs";
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

export type DBDiaryGenerationJob = typeof diaryGenerationJobs.$inferSelect;
export type DBDiaryGenerationJobForCreate =
  typeof diaryGenerationJobs.$inferInsert;
export type DBDiaryGenerationJobForUpdate = Pick<DBDiaryGenerationJob, "id"> &
  Partial<DBDiaryGenerationJob>;

export const createDBDiaryForCreate = (
  diaryId: string,
): Result<DBDiaryGenerationJobForCreate, never> => {
  return ok({
    diaryId,
    status: "PROCESSING",
  });
};
