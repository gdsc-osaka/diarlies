import { DrizzleError } from "drizzle-orm";
import { errorBuilder, ErrorType } from "../../shared/error";

type DBErrorCode = "unknown" | "not-found";

export interface DBError<
  T extends DBErrorCode = DBErrorCode,
  B extends string = "DBError",
> {
  readonly __brand: B;
  code: T;
  message: string;
  cause: unknown;
}

export const createDBError = <
  T extends DBErrorCode,
  B extends string = "DBError",
>(
  code: T,
  message: string,
  cause: unknown,
  brand?: B,
): DBError<T, B> => ({
  __brand: brand ?? ("DBError" as B),
  code,
  message,
  cause,
});

export const handleDBError = <B extends string = "DBError">(
  error: unknown,
  brand?: B,
): DBError<"unknown", B> => {
  // TODO: Handle drizzle error
  if (error instanceof DrizzleError) {
    return createDBError("unknown", error.message, error.cause, brand);
  }

  if (error instanceof Error) {
    return createDBError("unknown", error.message, error, brand);
  }

  return createDBError("unknown", JSON.stringify(error, null, 2), error, brand);
};

export type UserDBError<T extends DBErrorCode = DBErrorCode> = DBError<
  T,
  "UserDBError"
>;
export const createUserDBError = <T extends DBErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): DBError<T, "UserDBError"> =>
  createDBError(code, message, cause, "UserDBError");
export const handleUserDBError = (
  error: unknown,
): DBError<"unknown", "UserDBError"> => handleDBError(error, "UserDBError");

export const DBInternalError = errorBuilder("DBInternalError");
export type DBInternalError = ErrorType<typeof DBInternalError>;
