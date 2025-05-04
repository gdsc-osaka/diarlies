import {createMiddleware} from "hono/factory";
import {HTTPException} from "hono/http-exception";
import {AuthUser, verifyIdToken} from "../../infra/authenticator";

const authorize = createMiddleware<{
    Variables: {
        authUser: AuthUser;
    };
    Bindings: {
        FIRE_SA: string;
    }
}>(async (c, next) => {
    // check header
    const authorizationHeader = c.req.header("Authorization");
    if (!authorizationHeader) {
        throw new HTTPException(401, {message: "Missing Authorization header"});
    }

    // check format
    const bearerRegex = /^Bearer\s+(.+)$/;
    const match = authorizationHeader.match(bearerRegex);
    if (match === null || match.length < 2) {
        throw new HTTPException(401, {
            message: "Invalid Authorization header format",
        });
    }

    const res = await verifyIdToken(c.env.FIRE_SA, match[1]);

    if (res.isErr()) {
        throw new HTTPException(401, {message: res.error.message});
    }

    c.set("authUser", res.value);

    return next();
});

export default authorize;
