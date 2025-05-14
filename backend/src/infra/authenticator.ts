import { ResultAsync } from "neverthrow";
import { DecodedIdToken } from "firebase-admin/auth";
import { AuthError, handleAuthError } from "./error/auth-error";
import firebase from "../firebase";

export type AuthUser = DecodedIdToken;

export type VerifyIdToken = (
    fireSa: string,
    idToken: string,
) => ResultAsync<AuthUser, AuthError>;

export const verifyIdToken: VerifyIdToken = (fireSa, idToken) =>
    ResultAsync.fromPromise(
        firebase(fireSa).auth().verifyIdToken(idToken),
        handleAuthError,
    );