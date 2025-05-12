import { DrizzleError } from "drizzle-orm";

type DBErrorCode = "unknown" | "not-found";

export interface DBError<T extends DBErrorCode = DBErrorCode> {
  readonly __brand: "DBError";
  code: T;
  message: string;
  cause: unknown;
}

export const createDBError = <T extends DBErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): DBError<T> => ({
  __brand: "DBError",
  code,
  message,
  cause,
});

export const handleDBError = (error: unknown): DBError<"unknown"> => {
  // TODO: Handle drizzle error
  if (error instanceof DrizzleError) {
    return createDBError("unknown", error.message, error.cause);
  }

  if (error instanceof Error) {
    return createDBError("unknown", error.message, error);
  }

  return createDBError("unknown", JSON.stringify(error, null, 2), error);
};
