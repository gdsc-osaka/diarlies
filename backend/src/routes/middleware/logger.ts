import { createMiddleware } from "hono/factory";
import { accessLogger } from "../../logger";

export const logger = createMiddleware(async (c, next) => {
  const { method, path } = c.req;
  accessLogger("<--").info(`${method}#${path}`);

  const start = Date.now();
  const res = await next();
  const end = Date.now();

  const status = c.res.status;

  accessLogger("-->").info(`${method}#${path} ${status} ${end - start}ms`, {
    req: c.req,
    res: c.res,
  });

  return res;
});
