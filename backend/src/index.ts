import { Hono } from "hono";
import users from "./routes/users";
import { verifyFirebaseAuth } from "@hono/firebase-auth";
import { openApiSpec } from "./openapiSpec";
import { firebaseAuthConfig } from "./firebase";

const app = new Hono();

app.get("/openapi", openApiSpec(app));

app.use("*", verifyFirebaseAuth(firebaseAuthConfig));
app.route("/users", users);

export default app;
