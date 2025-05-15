import z from "zod";
import "zod-openapi/extend";
import { HTTPException } from "hono/http-exception";

export enum StatusCode {
  BadRequest = 400,
  Unauthorized = 401,
  Forbidden = 403,
  NotFound = 404,
  TooManyRequests = 429,
  InternalServerError = 500,
  NotImplemented = 501,
  ServiceUnavailable = 503,
}

const toMessage = (status: StatusCode): string => {
  switch (status) {
    case StatusCode.BadRequest:
      return "Bad Request";
    case StatusCode.Unauthorized:
      return "Unauthorized";
    case StatusCode.Forbidden:
      return "Forbidden";
    case StatusCode.NotFound:
      return "Not Found";
    case StatusCode.TooManyRequests:
      return "Too Many Requests";
    case StatusCode.InternalServerError:
      return "Internal Server Error";
    case StatusCode.NotImplemented:
      return "Not Implemented";
    case StatusCode.ServiceUnavailable:
      return "Service Unavailable";
  }
};

export const ServiceError = z
  .object({
    status: z.number().int(),
    message: z.string(),
    code: z.string().optional(),
    extra: z.record(z.unknown()).optional(),
  })
  .openapi({ ref: "ServiceError" });
export type ServiceError = z.infer<typeof ServiceError>;

export const createServiceError = <T extends string = never>(
  status: StatusCode,
  message: string,
  code?: T,
  extra?: Record<string, unknown>,
): {
  __brand: "ServiceError";
  status: number;
  message: string;
  code?: T;
  extra?: Record<string, unknown>;
} => {
  return {
    __brand: "ServiceError",
    status,
    message,
    ...(code ? { code } : {}),
    ...(extra ? { extra } : {}),
  };
};

export const toHTTPException = <T extends ServiceError>(err: T) =>
  new HTTPException(err.status as StatusCode, {
    message: err.message,
    res: new Response(
      JSON.stringify({
          __brand: "ServiceError",
        status: err.status,
        code: err.code,
        message: err.message,
        ...err.extra,
      }),
      {
        status: err.status,
        headers: {
          Authenticate: 'error="invalid_token"',
          "Content-Type": "application/json",
        },
      },
    ),
  });
