import {Hono} from "hono";
import authorize from "./middleware/authorize";
import {describeRoute} from "hono-openapi";
import {resolver} from "hono-openapi/arktype";
import {type} from "arktype";
import {User} from "../domain/user";
import {fetchUser} from "../service/user-service";
import {fetchUserByUid} from "../infra/user-repository";
import {HTTPException} from "hono/http-exception";
import {convertServiceErrorToJSON} from "../service/error/service-error";

const app = new Hono();

app.get(
    "/",
    authorize,
    describeRoute({
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
            // 409: {
            //     description: "Unauthorized",
            //     content: {
            //         "application/json": {
            //             schema: resolver(
            //                 type({
            //                     message: "string",
            //                     code: "'users/unauthorized'",
            //                 }),
            //             ),
            //         },
            //     },
            // },
        },
    }),
    async (c) => {
        const res = await fetchUser(
            fetchUserByUid,
        )(c.get("authUser"));
        if (res.isErr()) {
            throw new HTTPException(
                res.error.status,
                convertServiceErrorToJSON(res.error),
            );
        }
        return c.json({user: res.value});
    },
);

export default app;
