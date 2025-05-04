import { ResultAsync } from "neverthrow";
import { convertToUser, User } from "../domain/user";
import { AuthUser } from "../infra/authenticator";
import { FetchUserByUid } from "../infra/user-repository";
import { match } from "ts-pattern";
import db from "../db/db";
import { createServiceError, ServiceError } from "./error/service-error";

export type FetchUser = (authUser: AuthUser) => ResultAsync<User, ServiceError>;

export const fetchUser =
  (fetchUserByUid: FetchUserByUid): FetchUser =>
  (authUser: AuthUser) =>
    fetchUserByUid(db)(authUser.uid)
      .andThen(convertToUser)
      .mapErr((err) =>
        match(err)
          .with({ __brand: "DBError" }, (e) =>
            createServiceError(500, e.message),
          )
          .exhaustive(),
      );
