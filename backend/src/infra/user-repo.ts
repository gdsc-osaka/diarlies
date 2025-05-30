import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { users } from "../db/schema/users";
import { eq } from "drizzle-orm";
import { DBInternalError } from "./error/db-error";
import type { DBorTx } from "../db/db";
import { DBUser, DBUserForCreate, DBUserForUpdate } from "../domain/user";
import { infraLogger } from "../logger";
import {
  DBUserAlreadyExistsError,
  DBUserNotFoundError,
} from "./user-repo.error";

export type FetchDBUserByUid = (
  db: DBorTx,
) => (
  uid: string,
) => ResultAsync<DBUser, DBInternalError | DBUserNotFoundError>;

export const fetchDBUserByUid: FetchDBUserByUid = (db) => (uid) =>
  ResultAsync.fromPromise(
    db.select().from(users).where(eq(users.uid, uid)).limit(1).execute(),
    DBUserNotFoundError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBUserNotFoundError.build("User not found", { extra: { uid } }),
          ),
    )
    .orTee(infraLogger("fetchDBUserByUid").error);

export type FetchIfDBUserExists = (
  db: DBorTx,
) => (uid: string) => ResultAsync<boolean, DBInternalError>;

export const fetchIfDBUserExists: FetchIfDBUserExists = (db) => (uid) =>
  ResultAsync.fromPromise(
    db.select({}).from(users).where(eq(users.uid, uid)).limit(1).execute(),
    DBInternalError.handle,
  ).map((records) => records.length > 0);

export type CreateDBUser = (
  db: DBorTx,
) => (
  user: DBUserForCreate,
) => ResultAsync<DBUser, DBInternalError | DBUserAlreadyExistsError>;

export const createDBUser: CreateDBUser = (db) => (user) =>
  ResultAsync.fromPromise(
    db.insert(users).values(user).returning().execute(),
    DBUserAlreadyExistsError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBUserAlreadyExistsError.build("User already exists", {
              extra: { uid: user.uid },
            }),
          ),
    )
    .andTee(infraLogger("createDBUser").info)
    .orTee(infraLogger("createDBUser").error);

export type UpdateDBUser = (
  db: DBorTx,
) => (
  user: DBUserForUpdate,
) => ResultAsync<DBUser, DBInternalError | DBUserNotFoundError>;

export const updateDBUser: UpdateDBUser = (db) => (user) =>
  ResultAsync.fromPromise(
    db
      .update(users)
      .set(user)
      .where(eq(users.id, user.id))
      .returning()
      .execute(),
    DBInternalError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBUserNotFoundError.build("User not found", {
              extra: { id: user.id },
            }),
          ),
    )
    .andTee(infraLogger("updateDBUser").info)
    .orTee(infraLogger("updateDBUser").error);

export type DeleteDBUser = (
  db: DBorTx,
) => (
  dbUser: DBUser,
) => ResultAsync<DBUser, DBInternalError | DBUserNotFoundError>;

export const deleteDBUser: DeleteDBUser = (db) => (user) =>
  ResultAsync.fromPromise(
    db.delete(users).where(eq(users.id, user.id)).returning().execute(),
    DBInternalError.handle,
  )
    .andThen((records) =>
      records.length > 0
        ? okAsync(records[0])
        : errAsync(
            DBUserNotFoundError.build("User not found", {
              extra: { id: user.id },
            }),
          ),
    )
    .andTee(infraLogger("deleteDBUser").info)
    .orTee(infraLogger("deleteDBUser").error);
