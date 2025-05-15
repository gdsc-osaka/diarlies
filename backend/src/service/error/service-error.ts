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
