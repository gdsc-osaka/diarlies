import { Hono } from "hono";
import { verifyFirebaseAuth } from "@hono/firebase-auth";
import { openApiSpec } from "./openapiSpec";
import { firebaseAuthConfig } from "./firebase";
import users from "./routes/users";
import diaries from "./routes/diaries";

const app = new Hono();


// app.route("/diaries", diaries);
app.use("*", verifyFirebaseAuth(firebaseAuthConfig));
app.route("/users", users);

app.get("/openapi", openApiSpec(app));

export default app;
