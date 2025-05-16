import {Hono} from "hono";
import {describeRoute} from "hono-openapi";
import {AccountVisibility, User} from "../domain/user";
import {createUser, CreateUserServiceError, fetchUser, updateUserVisibility,} from "../service/user-service";
import {createDBUser, fetchDBUserByUid, updateDBUser} from "../infra/user-repository";
import {resolver} from "hono-openapi/zod";
import {toHTTPException} from "../service/error/service-error";
import db from "../db/db";
import {getAUthUser} from "./middleware/authorize";
import {zValidator} from "@hono/zod-validator";
import z from "zod";

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

// POST /users/:userId/change-visibility
app.post(
    "/:userId/change-visibility",
    describeRoute({
        tags,
        validateResponse: true,
        description: "Change user visibility",
        parameters: [
            {
                name: "userId",
                in: "path",
                description: "User ID to change visibility",
                required: true,
                schema: {
                    type: "object",
                    properties: {
                        visibility: {
                            type: "string",
                            enum: ["private", "public"],
                            description: "Visibility of the user",
                        }
                    },
                },
            },
        ],
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
    zValidator('param', z.object({
        userId: z.string().min(1),
    })),
    zValidator('json', z.object({
        visibility: AccountVisibility,
    })),
    async (c) => {
        const body = c.req.valid('json');
        const res = await updateUserVisibility(db(), fetchDBUserByUid, updateDBUser)(getAUthUser(c), c.req.valid('param').userId, body.visibility);

        if (res.isErr()) {
            throw toHTTPException(res.error);
        }

        return c.json(res.value);
    },
);

export default app;
