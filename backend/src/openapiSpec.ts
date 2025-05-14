import { openAPISpecs } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import { Hono } from "hono";
import { ServiceError } from "./service/error/service-error";
import { LanguageCode } from "./domain/language";

export const openApiSpec = (app: Hono) =>
  openAPISpecs(app, {
    documentation: {
      info: {
        title: "Hono API",
        version: "1.0.0",
        description: "Greeting API",
      },
      servers: [
        { url: "http://localhost:8080", description: "Local Server" },
        {
          url: "https://diarlies.harineko0927.workers.dev",
          description: "Production Server",
        },
      ],
      security: [
        {
          bearerAuth: [],
        },
      ],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: "http",
            scheme: "bearer",
            bearerFormat: "JWT",
          },
        },
        schemas: {
          LanguageCode: {
            type: "string",
            enum: LanguageCode.options,
            description: "Language code for diary generation",
          },
        },
      },
    },
    defaultOptions: {
      GET: {
        responses: {
          400: {
            description: "Bad Request",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          401: {
            description: "Unauthorized",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          403: {
            description: "Forbidden",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          404: {
            description: "Not Found",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          413: {
            description: "Payload Too Large",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          429: {
            description: "Too Many Requests",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          500: {
            description: "Internal Server Error",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
          503: {
            description: "Service Unavailable",
            content: {
              "application/json": {
                schema: resolver(ServiceError),
              },
            },
          },
        },
      },
    },
  });
