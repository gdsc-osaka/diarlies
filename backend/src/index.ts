import { Hono } from "hono";
import { logger } from "hono/logger";
import { serve } from "@hono/node-server";
import { verifyFirebaseAuth } from "@hono/firebase-auth";
import { openApiSpec } from "./openapiSpec";
import { firebaseAuthConfig } from "./firebase";
import users from "./routes/users";
import diaries from "./routes/diaries";

const app = new Hono();

app.get("/openapi", openApiSpec(app));

app.use(logger());
app.route("/diaries", diaries);
app.use("*", verifyFirebaseAuth(firebaseAuthConfig));
app.route("/users", users);


serve({
  fetch: app.fetch,
  port: 8080,
});

console.log("Server started");
