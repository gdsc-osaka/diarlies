import { date, index, pgTable, timestamp, varchar } from "drizzle-orm/pg-core";
import { CUID_LENGTH } from "../constants";
import { createId } from "@paralleldrive/cuid2";
import { relations } from "drizzle-orm/relations";
import { users } from "./users";
import { diaryGenerationJobs } from "./diary-generation-jobs";

export const diaries = pgTable(
  "diaries",
  {
    id: varchar("id", { length: CUID_LENGTH })
      .$defaultFn(() => createId())
      .primaryKey()
      .notNull(),
    userId: varchar("user_id", { length: CUID_LENGTH }).references(
      () => users.id,
      { onDelete: "cascade" },
    ),
    content: varchar("content", { length: 1000 }).notNull(),
    diaryDate: date("diary_date", { mode: "date" }).notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .$onUpdate(() => new Date())
      .notNull(),
  },
  (t) => [
    index("diaries_user_id_idx").using("btree", t.userId),
    index("diaries_diary_date_idx").using("btree", t.diaryDate),
  ],
);

export const diariesRelations = relations(diaries, ({ one }) => ({
  user: one(users, {
    fields: [diaries.userId],
    references: [users.id],
  }),
  diaryGenerationJobs: one(diaryGenerationJobs, {
    fields: [diaries.id],
    references: [diaryGenerationJobs.diaryId],
  }),
}));
