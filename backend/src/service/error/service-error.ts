type Status = 200 | 201 | 400 | 401 | 403 | 404 | 429 | 500 | 501 | 503;
type ErrorCode = string;
type DefaultErrorCode = "unknown";

export interface ServiceError<T extends ErrorCode = DefaultErrorCode> {
  readonly __brand: "ServiceError";
  status: Status;
  message: string;
  code: T;
}

export const createServiceError = <T extends ErrorCode = DefaultErrorCode>(
  status: Status,
  message: string,
  code?: T,
): ServiceError<T> =>
  code
    ? {
        __brand: "ServiceError",
        status,
        message,
        code: code,
      }
    : {
        __brand: "ServiceError",
        status,
        message,
        code: "unknown" as T,
      };
