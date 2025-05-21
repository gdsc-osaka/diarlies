type DiscordErrorCode = "unknown";

export interface DiscordError<T extends DiscordErrorCode = DiscordErrorCode> {
  readonly __brand: "DiscordError";
  code: T;
  message: string;
  cause: unknown;
}

export const createDiscordError = <T extends DiscordErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): DiscordError<T> => ({
  __brand: "DiscordError",
  code,
  message,
  cause,
});

export const handleDiscordError = (error: unknown): DiscordError<"unknown"> => {
  if (error instanceof Error) {
    return createDiscordError("unknown", error.message, error);
  }

  return createDiscordError("unknown", JSON.stringify(error, null, 2), error);
};
