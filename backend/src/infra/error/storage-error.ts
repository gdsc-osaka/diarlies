type StorageErrorCode = "unknown" | "not-found";

export interface StorageError<T extends StorageErrorCode = StorageErrorCode> {
  readonly __brand: "StorageError";
  code: T;
  message: string;
  cause: unknown;
}

export const createStorageError = <T extends StorageErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): StorageError<T> => ({
  __brand: "StorageError",
  code,
  message,
  cause,
});

export const handleStorageError = (error: unknown): StorageError<"unknown"> => {
  if (error instanceof Error) {
    return createStorageError("unknown", error.message, error);
  }

  return createStorageError("unknown", JSON.stringify(error, null, 2), error);
};
