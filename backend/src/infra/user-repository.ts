import {errAsync, okAsync, ResultAsync} from "neverthrow";
import {users} from "../db/schema/users";
import {eq} from "drizzle-orm";
import {createDBError, DBError, handleDBError} from "./error/db-error";
import type {DBorTx} from "../db/db";
import {DBUser, DBUserForCreate, DBUserForUpdate} from "../domain/user";
import {infraLogger} from "../logger";

export type FetchDBUserByUid = (
    db: DBorTx,
) => (uid: string) => ResultAsync<DBUser, DBError<"unknown" | "not-found">>;

export const fetchDBUserByUid: FetchDBUserByUid = (db) => (uid) =>
    ResultAsync.fromPromise(
        db.select().from(users).where(eq(users.uid, uid)).limit(1).execute(),
        handleDBError,
    )
        .andThen((records) =>
            records.length > 0
                ? okAsync(records[0])
                : errAsync(
                    createDBError(
                        "not-found",
                        `User with uid ${uid} not found`,
                        undefined,
                    ),
                ),
        )
        .orTee(infraLogger.error);

export type FetchIfDBUserExists = (
    db: DBorTx,
) => (uid: string) => ResultAsync<boolean, DBError<"unknown">>;

export const fetchIfDBUserExists: FetchIfDBUserExists = (db) => (uid) =>
    ResultAsync.fromPromise(
        db.select({}).from(users).where(eq(users.uid, uid)).limit(1).execute(),
        handleDBError,
    ).map((records) => records.length > 0);

export type CreateDBUser = (
    db: DBorTx,
) => (user: DBUserForCreate) => ResultAsync<DBUser, DBError<"unknown">>;

export const createDBUser: CreateDBUser = (db) => (user) =>
    ResultAsync.fromPromise(
        db.insert(users).values(user).returning().execute(),
        handleDBError,
    )
        .andThen((records) =>
            records.length > 0
                ? okAsync(records[0])
                : errAsync(
                    createDBError(
                        "unknown",
                        `User with uid ${user.uid} not created`,
                        undefined,
                    ),
                ),
        )
        .orTee(infraLogger.error);

export type UpdateDBUser = (
    db: DBorTx,
) => (user: DBUserForUpdate) => ResultAsync<DBUser, DBError<"unknown">>;

export const updateDBUser: UpdateDBUser = (db) => (user) =>
    ResultAsync.fromPromise(
        db
            .update(users)
            .set(user)
            .where(eq(users.id, user.id))
            .returning()
            .execute(),
        handleDBError,
    )
        .andThen((records) =>
            records.length > 0
                ? okAsync(records[0])
                : errAsync(
                    createDBError(
                        "unknown",
                        `User with id ${user.id} not updated`,
                        undefined,
                    ),
                ),
        )
        .orTee(infraLogger.error);