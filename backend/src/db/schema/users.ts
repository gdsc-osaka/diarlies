import { createId } from "@paralleldrive/cuid2";
import {
  index,
  pgTable,
  timestamp,
  varchar,
  pgEnum,
} from "drizzle-orm/pg-core";
import { CUID_LENGTH } from "../constants";
import { relations } from "drizzle-orm/relations";
import { diaries } from "./diaries";

const UID_LENGTH = 28;

export const accountVisibility = pgEnum("account_visibility", [
  "private",
  "public",
]);

export const users = pgTable(
  "users",
  {
    id: varchar("id", { length: CUID_LENGTH })
      .$defaultFn(() => createId())
      .primaryKey()
      .notNull(),
    uid: varchar("uid", { length: UID_LENGTH }).notNull().unique(),
    visibility: accountVisibility("visibility").default("private").notNull(),
    iconUrl: varchar("icon_url", { length: 255 }),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .$onUpdate(() => new Date())
      .notNull(),
  },
  (t) => [index("users_uid_idx").using("btree", t.uid)],
);

export const usersRelations = relations(users, ({ many }) => ({
  diaries: many(diaries),
}));
