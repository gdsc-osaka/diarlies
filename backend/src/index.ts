import { Hono } from "hono";
import { serve } from "@hono/node-server";
import { openApiSpec } from "./openapiSpec";
import authorize from "./routes/middleware/authorize";
import users from "./routes/users";
import diaries from "./routes/diaries";
import usersDiaries from "./routes/users-diaries";
import env from "./env";
import { logger } from "./routes/middleware/logger";
import { DBUserNotFoundError } from "./infra/user-repo.error";

const app = new Hono();

// Production 環境では Firebase Hosting で /api/** のパスを受け取る

app.use(logger);
app.get("/api/openapi", openApiSpec(app));
app.use("/api/*", authorize);
app.route("/api/users", users);
app.route("/api/users/:userId/diaries", usersDiaries);
app.route("/api/diaries", diaries);

serve({
  fetch: app.fetch,
  port: env.PORT,
});

console.log(
  "test",
  JSON.stringify(
    DBUserNotFoundError("Test", {
      extra: { uid: "12345" },
    }),
    null,
    2,
  ),
);

console.log("Server started");
