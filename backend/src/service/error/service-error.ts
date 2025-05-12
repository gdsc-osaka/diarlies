import z from "zod";
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
    __brand: z.literal("ServiceError"),
  })
  .openapi({ ref: "ServiceError" });
export type ServiceError = z.infer<typeof ServiceError>;

export const createServiceError = <T extends string = never>(
  status: StatusCode,
  message: string,
  code?: T,
): { __brand: "ServiceError"; status: number; message: string; code?: T } =>
  code
    ? {
        __brand: "ServiceError",
        status: status,
        code: code,
        message,
      }
    : {
        __brand: "ServiceError",
        status,
        code: "unknown" as T,
        message,
      };

export const toHTTPException = <T extends ServiceError>(err: T) =>
  new HTTPException(err.status as StatusCode, {
    message: err.message,
    res: new Response("Unauthorized", {
      status: 401,
      headers: {
        Authenticate: 'error="invalid_token"',
      },
    }),
  });
