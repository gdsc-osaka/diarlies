import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { DBUser, users } from "../db/schema/users";
import { eq } from "drizzle-orm";
import { createDBError, DBError, handleDBError } from "./error/db-error";
import type { DB } from "../db/db";

export type FetchUserByUid = (
  db: DB,
) => (uid: string) => ResultAsync<DBUser, DBError<"unknown" | "not-found">>;

export const fetchUserByUid: FetchUserByUid = (db) => (uid) =>
  ResultAsync.fromPromise(
    db.select().from(users).where(eq(users.uid, uid)).limit(1).execute(),
    handleDBError,
  ).andThen((records) =>
    records.length > 0
      ? okAsync(records[0])
      : errAsync(
          createDBError(
            "not-found",
            `User with uid ${uid} not found`,
            undefined,
          ),
        ),
  );
