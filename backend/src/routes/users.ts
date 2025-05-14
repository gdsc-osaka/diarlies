import { Hono } from "hono";
import { describeRoute } from "hono-openapi";
import { User } from "../domain/user";
import {
  createUser,
  CreateUserServiceError,
  fetchUser,
} from "../service/user-service";
import { createDBUser, fetchDBUserByUid } from "../infra/user-repository";
import { resolver } from "hono-openapi/zod";
import { toHTTPException } from "../service/error/service-error";
import db from "../db/db";
import {getAUthUser} from "./middleware/authorize";

const app = new Hono();
const tags = ["Users"];

app.get(
  "/",
  describeRoute({
    tags,
    validateResponse: true,
    description: "Get user information",
    responses: {
      200: {
        description: "Successful response",
        content: {
          "application/json": {
            schema: resolver(User),
          },
        },
      },
    },
  }),
  async (c) => {
    const res = await fetchUser(fetchDBUserByUid, db())(getAUthUser(c));
    if (res.isErr()) {
      throw toHTTPException(res.error);
    }
    return c.json(res.value);
  },
);

app.post(
  "/",
  describeRoute({
    tags,
    validateResponse: true,
    description: "Create a new user",
    responses: {
      201: {
        description: "User created successfully",
        content: {
          "application/json": {
            schema: resolver(User),
          },
        },
      },
      400: {
        description: "Bad Request",
        content: {
          "application/json": {
            schema: resolver(CreateUserServiceError),
          },
        },
      },
    },
  }),
  async (c) => {
    const res = await createUser(
      createDBUser,
      fetchDBUserByUid,
      db(),
    )(getAUthUser(c));
    if (res.isErr()) {
      throw toHTTPException(res.error);
    }
    return c.json(res.value, 201);
  },
);

export default app;
