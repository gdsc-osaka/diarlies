import { ResultAsync } from "neverthrow";
import { DecodedIdToken } from "firebase-admin/auth";
import { AuthError, handleAuthError } from "./error/auth-error";
import firebase from "../firebase";
import { infraLogger } from "../logger";
import env from "../env";

export type AuthUser = DecodedIdToken;

export type VerifyIdToken = (
  fireSa: string,
  idToken: string,
) => ResultAsync<AuthUser, AuthError>;

export const verifyIdToken: VerifyIdToken = (fireSa, idToken) =>
  ResultAsync.fromPromise(
    firebase(fireSa).auth().verifyIdToken(idToken),
    handleAuthError,
  ).orTee(infraLogger.error);

export type DeleteAuthUser = (uid: string) => ResultAsync<void, AuthError>;

export const deleteAuthUser: DeleteAuthUser = (uid) =>
  ResultAsync.fromPromise(
    firebase(env.FIRE_SA).auth().deleteUser(uid),
    handleAuthError,
  ).orTee(infraLogger.error);
