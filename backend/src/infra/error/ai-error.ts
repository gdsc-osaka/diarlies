type AIErrorCode = "unknown" | "not-found";

export interface AIError<T extends AIErrorCode = AIErrorCode> {
  readonly __brand: "AIError";
  code: T;
  message: string;
  cause: unknown;
}

export const createAIError = <T extends AIErrorCode>(
  code: T,
  message: string,
  cause: unknown,
): AIError<T> => ({
  __brand: "AIError",
  code,
  message,
  cause,
});

export const handleAIError = (error: unknown): AIError<"unknown"> => {
  if (error instanceof Error) {
    return createAIError("unknown", error.message, error);
  }

  return createAIError("unknown", JSON.stringify(error, null, 2), error);
};
