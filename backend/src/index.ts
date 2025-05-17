import { Hono } from "hono";
import { logger } from "hono/logger";
import { serve } from "@hono/node-server";
import { openApiSpec } from "./openapiSpec";
import authorize from "./routes/middleware/authorize";
import users from "./routes/users";
import diaries from "./routes/diaries";
import usersDiaries from "./routes/users-diaries";
import env from "./env";

const app = new Hono();

// Production 環境では Firebase Hosting で /api/** のパスを受け取るが, Firebase Hosting は
// プレフィックスを削除できないので, ここでプレフィックスを削除する
app.use((c, next) => {
  if (c.req.path.startsWith("/api/")) {
    c.req.path = c.req.path.replace("/api", "");
  }

  return next();
});

app.get("/openapi", openApiSpec(app));

app.use(logger());
app.use(authorize);
app.route("/users", users);
app.route("/users/:userId/diaries", usersDiaries);
app.route("/diaries", diaries);

serve({
  fetch: app.fetch,
  port: env.PORT,
});

console.log("Server started");
