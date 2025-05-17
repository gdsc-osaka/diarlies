import { Hono } from "hono";
import { describeRoute } from "hono-openapi";
import { AccountVisibility, User } from "../domain/user";
import {
  createUser,
  CreateUserServiceError,
  deleteUser,
  fetchUser,
  updateUserVisibility,
} from "../service/user-service";
import {
  createDBUser,
  deleteDBUser,
  fetchDBUserByUid,
  updateDBUser,
} from "../infra/user-repository";
import { resolver } from "hono-openapi/zod";
import { toHTTPException } from "../service/error/service-error";
import db from "../db/db";
import { getAUthUser } from "./middleware/authorize";
import { zValidator } from "@hono/zod-validator";
import z from "zod";
import { deleteAuthUser } from "../infra/authenticator";

const app = new Hono();
const tags = ["Users"];

app.get(
  "/",
  describeRoute({
    tags,
    validateResponse: true,
    operationId: "getUser",
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
    operationId: "createUser",
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

// POST /users/:userId/change-visibility
app.post(
  "/:userId/change-visibility",
  describeRoute({
    tags,
    validateResponse: true,
    operationId: "changeUserVisibility",
    description: "Change user visibility",
    parameters: [
      {
        name: "userId",
        in: "path",
        description: "User ID to change visibility",
        required: true,
        schema: {
          type: "string",
          minLength: 1,
        },
      },
    ],
    requestBody: {
      required: true,
      content: {
        "application/json": {
          schema: {
            title: "ChangeUserVisibilityRequest",
            type: "object",
            properties: {
              visibility: {
                $ref: "#/components/schemas/AccountVisibility",
              },
            },
            required: ["visibility"],
          },
        },
      },
    },
    responses: {
      200: {
        description: "User visibility changed successfully",
        content: {
          "application/json": {
            schema: resolver(User),
          },
        },
      },
    },
  }),
  zValidator(
    "param",
    z.object({
      userId: z.string().min(1),
    }),
  ),
  zValidator(
    "json",
    z.object({
      visibility: AccountVisibility,
    }),
  ),
  async (c) => {
    const body = c.req.valid("json");
    const res = await updateUserVisibility(
      db(),
      fetchDBUserByUid,
      updateDBUser,
    )(getAUthUser(c), c.req.valid("param").userId, body.visibility);

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(res.value);
  },
);

app.delete(
  "/:userId",
  describeRoute({
    tags,
    operationId: "deleteUser",
    description: "Delete user",
  validateResponse: true,
    parameters: [
      {
        name: "userId",
        in: "path",
        description: "User ID to delete",
        required: true,
        schema: {
          type: "string",
          minLength: 1,
        },
      },
    ],
    responses: {
      204: {
        description: "User deleted successfully",
      },
    },
  }),
  zValidator(
    "param",
    z.object({
      userId: z.string().min(1),
    }),
  ),
  async (c) => {
    const res = await deleteUser(
      db(),
      fetchDBUserByUid,
      deleteDBUser,
      deleteAuthUser,
    )(getAUthUser(c));

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(null, 200);
  },
);

export default app;
