import {errAsync, okAsync, ResultAsync} from "neverthrow";
import {
    AccountVisibility,
    convertToUser,
    createDBUserForCreate,
    isSameUser,
    updateDBUserVisibility,
    User
} from "../domain/user";
import {CreateDBUser, FetchDBUserByUid, UpdateDBUser} from "../infra/user-repository";
import {match} from "ts-pattern";
import {createServiceError, ServiceError, StatusCode,} from "./error/service-error";
import {AuthUser} from "../domain/auth";
import z from "zod";
import {DB, DBorTx} from "../db/db";

export type FetchUser = (authUser: AuthUser) => ResultAsync<User, ServiceError>;

export const fetchUser =
    (fetchUserByUid: FetchDBUserByUid, db: DB): FetchUser =>
        (authUser: AuthUser) =>
            authUser === null
                ? errAsync(createServiceError(StatusCode.Unauthorized, "Unauthorized"))
                : fetchUserByUid(db)(authUser.uid)
                    .andThen(convertToUser)
                    .mapErr((err) =>
                        match(err)
                            .with({__brand: "DBError"}, (e) =>
                                createServiceError(
                                    match(e.code)
                                        .with("not-found", () => StatusCode.NotFound)
                                        .with("unknown", () => StatusCode.InternalServerError)
                                        .exhaustive(),
                                    e.message,
                                ),
                            )
                            .exhaustive(),
                    );

export const CreateUserServiceError = ServiceError.extend({
    code: z.enum(["user-already-exists", "unknown"]).optional(),
    user: User.optional(),
}).openapi({ref: "CreateUserServiceError"});
export type CreateUserServiceError = z.infer<typeof CreateUserServiceError>;

export type CreateUser = (
    authUser: AuthUser,
) => ResultAsync<User, CreateUserServiceError>;

export const createUser =
    (
        createDBUser: CreateDBUser,
        fetchDBUserByUid: FetchDBUserByUid,
        db: DB,
    ): CreateUser =>
        (authUser: AuthUser): ResultAsync<User, CreateUserServiceError> =>
            fetchDBUserByUid(db)(authUser.uid)
                .andThen(convertToUser)
                .orElse((err) =>
                    match(err)
                        .with({__brand: "DBError", code: "not-found"}, () => okAsync())
                        .with({__brand: "DBError", code: "unknown"}, (e) => errAsync(e))
                        .exhaustive(),
                )
                .andThen((user) =>
                    user
                        ? errAsync(
                            createServiceError(
                                StatusCode.BadRequest,
                                "User already exists",
                                "user-already-exists",
                                {user},
                            ),
                        )
                        : okAsync(),
                )
                .andThen(() => createDBUserForCreate(authUser))
                .andThen(createDBUser(db))
                .andThen(convertToUser)
                .mapErr((err) =>
                    match(err)
                        .with({__brand: "ServiceError"}, (e) => e)
                        .with({__brand: "DBError"}, (e) =>
                            createServiceError(
                                match(e.code)
                                    .with("unknown", () => StatusCode.InternalServerError)
                                    .exhaustive(),
                                e.message,
                            ),
                        )
                        .exhaustive(),
                );

export type UpdateUserVisibility = (
    authUser: AuthUser,
    id: string,
    visibility: AccountVisibility,
) => ResultAsync<User, ServiceError>;

export const updateUserVisibility =
    (db: DBorTx, fetchDBUserByUid: FetchDBUserByUid, updateDBUser: UpdateDBUser): UpdateUserVisibility =>
        (authUser: AuthUser, id: string, visibility: AccountVisibility): ResultAsync<User, ServiceError> =>
            fetchDBUserByUid(db)(authUser.uid)
                .andThen((user) => isSameUser(user, authUser))
                .andThen((user) => updateDBUserVisibility(user, visibility))
                .andThen(updateDBUser(db))
                .andThen(convertToUser)
                .mapErr((err) =>
                    match(err)
                        .with({__brand: "DBError"}, (e) =>
                            createServiceError(
                                match(e.code)
                                    .with("not-found", () => StatusCode.NotFound)
                                    .with("unknown", () => StatusCode.InternalServerError)
                                    .exhaustive(),
                                e.message,
                            ),
                        )
                        .with('wrong-user', () => createServiceError(StatusCode.Forbidden, "Wrong user", "wrong-user"))
                        .exhaustive(),
                );
