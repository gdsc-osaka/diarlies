type MapErrorCode = "unknown";

export interface MapError<T extends MapErrorCode = MapErrorCode> {
  readonly __brand: "MapError";
  code: T;
  message: string;
  cause: unknown;
}

export const createMapError = <T extends MapErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): MapError<T> => ({
  __brand: "MapError",
  code,
  message,
  cause,
});

export const handleMapError = (error: unknown): MapError<"unknown"> => {
  if (error instanceof Error) {
    return createMapError("unknown", error.message, error);
  }

  return createMapError("unknown", JSON.stringify(error, null, 2), error);
};
