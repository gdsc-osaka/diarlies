import { pgEnum, pgTable, text, timestamp, varchar } from "drizzle-orm/pg-core";
import { CUID_LENGTH } from "../constants";
import { createId } from "@paralleldrive/cuid2";
import { relations } from "drizzle-orm/relations";
import { diaries } from "./diaries";

export const diaryGenerationEnum = pgEnum("diary_generation_enum", [
  "PROCESSING",
  "COMPLETED",
  "FAILED",
]);

export const diaryGenerationJobs = pgTable(
  "diary_generation_jobs",
  {
    id: varchar("id", { length: CUID_LENGTH })
      .$defaultFn(() => createId())
      .primaryKey()
      .notNull(),
    // diaryGenerationJob 作成時点では Diary は存在しないため、nullable かつ外部キー制約なし
    diaryId: varchar("diary_id", { length: CUID_LENGTH }),
    status: diaryGenerationEnum("status").notNull(),
    errorMessage: text("error_message"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .$onUpdate(() => new Date())
      .notNull(),
    completedAt: timestamp("completed_at"),
  },
  (t) => [],
);

export const diariesRelations = relations(diaryGenerationJobs, ({ one }) => ({
  diary: one(diaries, {
    fields: [diaryGenerationJobs.diaryId],
    references: [diaries.id],
  }),
}));
