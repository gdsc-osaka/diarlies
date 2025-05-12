import { createMiddleware } from "hono/factory";

const cleanBrandedType = createMiddleware(async (c, next) => {
  await next();

  const body = c.res.clone();
  const contentType = c.res.headers.get("content-type");
  if (!contentType) {
    return;
  }

  const splitedContentType = contentType.split(";")[0];
  if (!splitedContentType.includes("application/json")) {
    return;
  }

  const json = await body.json();
  if (typeof json === "object" && json !== null && "__brand" in json) {
    delete json.__brand;

    return c.json(json, body.status as any);
  }
});

export default cleanBrandedType;
