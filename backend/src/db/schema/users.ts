import { createId } from "@paralleldrive/cuid2";
import { index, pgTable, timestamp, varchar } from "drizzle-orm/pg-core";
import { CUID_LENGTH } from "../constants";

const UID_LENGTH = 28;

export const users = pgTable(
  "users",
  {
    id: varchar("id", { length: CUID_LENGTH })
      .$defaultFn(() => createId())
      .primaryKey()
      .notNull(),
    uid: varchar("uid", { length: UID_LENGTH }).notNull().unique(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .$onUpdate(() => new Date())
      .notNull(),
  },
  (t) => [index("users_uid_idx").using("btree", t.uid)],
);

export type DBUser = typeof users.$inferSelect;
