import { errAsync, okAsync, ResultAsync } from "neverthrow";
import {
  AccountVisibility,
  convertToUser,
  createDBUserForCreate,
  isSameUser,
  updateDBUserVisibility,
  User,
} from "../domain/user";
import {
  CreateDBUser,
  DeleteDBUser,
  FetchDBUserByUid,
  UpdateDBUser,
} from "../infra/user-repo";
import { match, P } from "ts-pattern";
import {
  createServiceError,
  ServiceError,
  StatusCode,
} from "./error/service-error";
import { AuthUser } from "../domain/auth";
import z from "zod";
import { DB, DBorTx } from "../db/db";
import { DeleteAuthUser } from "../infra/auth-repo";
import { serviceLogger } from "../logger";
import { id } from "../shared/func";
import { DBInternalError } from "../infra/error/db-error";
import {
  DBUserAlreadyExistsError,
  DBUserNotFoundError,
} from "../infra/user-repo.error";
import {
  AuthTokenRevokedError,
  AuthUnknownError,
  AuthUserDisabledError,
  AuthUserNotFoundError,
} from "../infra/auth-repo.error";

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
              .with(DBInternalError.is, (e) =>
                createServiceError(StatusCode.InternalServerError, e.message),
              )
              .with(DBUserNotFoundError.is, (e) =>
                createServiceError(
                  StatusCode.NotFound,
                  e.message,
                  "user-not-found",
                  { uid: authUser.uid },
                ),
              )
              .exhaustive(),
          );

export const CreateUserServiceError = ServiceError.extend({
  code: z.enum(["user-already-exists", "unknown"]).optional(),
  user: User.optional(),
}).openapi({ ref: "CreateUserServiceError" });
export type CreateUserServiceError = z.infer<typeof CreateUserServiceError>;

export type CreateUser = (
  authUser: AuthUser,
) => ResultAsync<User, CreateUserServiceError>;

export const createUserLogger = serviceLogger("createUser");

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
          .with(DBUserNotFoundError.is, () => okAsync())
          .with(DBInternalError.is, (e) => errAsync(e))
          .exhaustive(),
      )
      .andThen((user) =>
        user
          ? errAsync(
              createServiceError(
                StatusCode.BadRequest,
                "User already exists",
                "user-already-exists",
                { user },
              ),
            )
          : okAsync(),
      )
      .andThen(() => createDBUserForCreate(authUser))
      .andThen(createDBUser(db))
      .andThen(convertToUser)
      .mapErr((err) =>
        match(err)
          .with({ __brand: "ServiceError" }, id)
          .with(DBInternalError.is, (e) =>
            createServiceError(StatusCode.InternalServerError, e.message),
          )
          .with(DBUserAlreadyExistsError.is, (e) =>
            createServiceError(
              StatusCode.BadRequest,
              e.message,
              "user-already-exists",
            ),
          )
          .exhaustive(),
      )
      .orTee(createUserLogger.error);

export type UpdateUserVisibility = (
  authUser: AuthUser,
  id: string,
  visibility: AccountVisibility,
) => ResultAsync<User, ServiceError>;

export const updateUserVisibilityLogger = serviceLogger("updateUserVisibility");

export const updateUserVisibility =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    updateDBUser: UpdateDBUser,
  ): UpdateUserVisibility =>
  (
    authUser: AuthUser,
    id: string,
    visibility: AccountVisibility,
  ): ResultAsync<User, ServiceError> =>
    fetchDBUserByUid(db)(authUser.uid)
      .andThen((user) => isSameUser(user, authUser))
      .andThen((user) => updateDBUserVisibility(user, visibility))
      .andThen(updateDBUser(db))
      .andThen(convertToUser)
      .mapErr((err) =>
        match(err)
          .with(DBInternalError.is, (e) =>
            createServiceError(StatusCode.InternalServerError, e.message),
          )
          .with(DBUserNotFoundError.is, (e) =>
            createServiceError(
              StatusCode.NotFound,
              e.message,
              "user-not-found",
              { id },
            ),
          )
          .with("wrong-user", () =>
            createServiceError(
              StatusCode.Forbidden,
              "Wrong user",
              "wrong-user",
            ),
          )
          .exhaustive(),
      )
      .orTee(updateUserVisibilityLogger.error);

export type DeleteUser = (
  authUser: AuthUser,
) => ResultAsync<User, ServiceError>;

export const deleteUserLogger = serviceLogger("deleteUser");

export const deleteUser =
  (
    db: DBorTx,
    fetchDBUserByUid: FetchDBUserByUid,
    deleteDBUser: DeleteDBUser,
    deleteAuthUser: DeleteAuthUser,
  ): DeleteUser =>
  (authUser: AuthUser): ResultAsync<User, ServiceError> =>
    fetchDBUserByUid(db)(authUser.uid)
      .andThen((user) => isSameUser(user, authUser))
      .andThen(deleteDBUser(db))
      .andThen((dbUser) => deleteAuthUser(dbUser.uid).map(() => dbUser))
      .andThen(convertToUser)
      .mapErr((err) =>
        match(err)
          .with(DBUserNotFoundError.is, (e) =>
            createServiceError(StatusCode.NotFound, e.message),
          )
          .with(DBInternalError.is, (e) =>
            createServiceError(StatusCode.InternalServerError, e.message),
          )
          .with(
            P.union(AuthUserNotFoundError.is, AuthUserDisabledError.is),
            (e) => createServiceError(StatusCode.NotFound, e.message),
          )
          .with(AuthTokenRevokedError.is, (e) =>
            createServiceError(StatusCode.Unauthorized, e.message),
          )
          .with(AuthUnknownError.is, (e) =>
            createServiceError(StatusCode.InternalServerError, e.message),
          )
          .with("wrong-user", () =>
            createServiceError(
              StatusCode.Forbidden,
              "Permission denied",
              "permission-denied",
            ),
          )
          .exhaustive(),
      )
      .orTee(deleteUserLogger.error);
