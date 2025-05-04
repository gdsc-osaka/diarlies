import {Hono} from "hono";
import authorize from "./middleware/authorize";
import {describeRoute} from "hono-openapi";
import {User} from "../domain/user";
import {fetchUser} from "../service/user-service";
import {fetchUserByUid} from "../infra/user-repository";
import {HTTPException} from "hono/http-exception";
import {resolver} from "hono-openapi/zod";
import {ApiError, convertToApiError} from "./error/api-error";

const app = new Hono();
const tags = ["Users"];

app.get(
    "/",
    authorize,
    describeRoute({
        tags,
        validateResponse: true,
        description: "Say hello to the user",
        responses: {
            200: {
                description: "Successful response",
                content: {
                    "application/json": {
                        schema: resolver(User),
                    },
                },
            },
        }}),
    async (c) => {
        const res = await fetchUser(fetchUserByUid)(c.get("authUser"));
        if (res.isErr()) {
            throw new HTTPException(
                res.error.status,
                convertToApiError(res.error),
            );
        }
        return c.json({user: res.value});
    },
);

export default app;
