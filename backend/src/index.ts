import { Hono } from "hono";
import { openAPISpecs } from "hono-openapi";
import users from "./routes/users";
import { resolver } from "hono-openapi/zod";
import { ApiError } from "./routes/error/api-error";

const app = new Hono();

app.route("/users", users);

app.get(
  "/openapi",
  openAPISpecs(app, {
    documentation: {
      info: {
        title: "Hono API",
        version: "1.0.0",
        description: "Greeting API",
      },
      servers: [
        { url: "http://localhost:3000", description: "Local Server" },
        {
          url: "https://diarlies.harineko0927.workers.dev",
          description: "Production Server",
        },
      ],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: "http",
            scheme: "Bearer",
            bearerFormat: "JWT",
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
                schema: resolver(ApiError),
              },
            },
          },
          401: {
            description: "Unauthorized",
            content: {
              "application/json": {
                schema: resolver(ApiError),
              },
            },
          },
          403: {
            description: "Forbidden",
            content: {
              "application/json": {
                schema: resolver(ApiError),
              },
            },
          },
          404: {
            description: "Not Found",
            content: {
              "application/json": {
                schema: resolver(ApiError),
              },
            },
          },
          429: {
            description: "Too Many Requests",
            content: {
              "application/json": {
                schema: resolver(ApiError),
              },
            },
          },
          500: {
            description: "Internal Server Error",
            content: {
              "application/json": {
                schema: resolver(ApiError),
              },
            },
          },
          503: {
            description: "Service Unavailable",
            content: {
              "application/json": {
                schema: resolver(ApiError),
              },
            },
          },
        },
      },
    },
  }),
);

export default app;
