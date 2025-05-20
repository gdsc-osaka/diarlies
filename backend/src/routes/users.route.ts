import { describeRoute } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import { User } from "../domain/user";
import { CreateUserServiceError } from "../service/user-service";

const tags = ["Users"];

const getUser = describeRoute({
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
});

const createUser = describeRoute({
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
});

const changeUserVisibility = describeRoute({
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
});

const deleteUser = describeRoute({
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
});

export default {
  getUser,
  createUser,
  deleteUser,
  changeUserVisibility,
};
