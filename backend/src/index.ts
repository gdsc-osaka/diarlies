import { Hono } from "hono";

const app = new Hono();

app.get("/", (c) => {
  return c.text("Hello Hono!");
});

export default app;

// import { OpenAPIHono } from '@hono/zod-openapi';
//
// const app = new OpenAPIHono();
//
// app.post('/', (c) => {
//   return c.text('Hello Hono!')
// });
//
// export default app;
