import { FirebaseAuthError } from "firebase-admin/auth";

type AUthErrorCode =
  | "token-revoked"
  | "user-disabled"
  | "unknown"
  | "not-found";

export interface AuthError<T extends AUthErrorCode = AUthErrorCode> {
  readonly __brand: "AuthError";
  code: T;
  message: string;
  cause: unknown;
}

export const createAuthError = <T extends AUthErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): AuthError<T> => ({
  __brand: "AuthError",
  code,
  message,
  cause,
});

const errorCodes = new Map<string, AUthErrorCode>([
  ["auth/user-disabled", "user-disabled"],
  ["auth/id-token-revoked", "token-revoked"],
  ["auth/user-not-found", "not-found"],
]);

export const handleAuthError = (error: unknown): AuthError => {
  if (error instanceof FirebaseAuthError) {
    return createAuthError(
      errorCodes.get(error.code) ?? "unknown",
      error.message,
      error.cause,
    );
  }

  if (error instanceof Error) {
    return createAuthError("unknown", error.message, error);
  }

  return createAuthError("unknown", JSON.stringify(error, null, 2), error);
};
