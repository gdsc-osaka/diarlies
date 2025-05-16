import { Hono } from "hono";
import { logger } from "hono/logger";
import { serve } from "@hono/node-server";
import { openApiSpec } from "./openapiSpec";
import authorize from "./routes/middleware/authorize";
import users from "./routes/users";
import diaries from "./routes/diaries";
import usersDiaries from "./routes/users-diaries";

const app = new Hono();

app.get("/openapi", openApiSpec(app));

app.use(logger());
app.use(authorize);
app.route("/users", users);
app.route("/users/:userId/diaries", usersDiaries);
app.route("/diaries", diaries);

serve({
  fetch: app.fetch,
  port: 8080,
});

console.log("Server started");
