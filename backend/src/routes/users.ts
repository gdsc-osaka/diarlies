import { Hono } from "hono";
import { AccountVisibility } from "../domain/user";
import {
  createUser,
  deleteUser,
  fetchUser,
  updateUserVisibility,
} from "../service/user-service";
import {
  createDBUser,
  deleteDBUser,
  fetchDBUserByUid,
  updateDBUser,
} from "../infra/user-repo";
import { toHTTPException } from "../service/error/service-error";
import db from "../db/db";
import { getAUthUser } from "./middleware/authorize";
import { zValidator } from "@hono/zod-validator";
import z from "zod";
import { deleteAuthUser } from "../infra/authenticator";
import usersRoute from "./users.route";

const app = new Hono();

app.get("/", usersRoute.getUser, async (c) => {
  const res = await fetchUser(fetchDBUserByUid, db())(getAUthUser(c));
  if (res.isErr()) {
    throw toHTTPException(res.error);
  }
  return c.json(res.value);
});

app.post("/", usersRoute.createUser, async (c) => {
  const res = await createUser(
    createDBUser,
    fetchDBUserByUid,
    db(),
  )(getAUthUser(c));
  if (res.isErr()) {
    throw toHTTPException(res.error);
  }
  return c.json(res.value, 201);
});

// POST /users/:userId/change-visibility
app.post(
  "/:userId/change-visibility",
  usersRoute.changeUserVisibility,
  zValidator(
    "param",
    z.object({
      userId: z.string().min(1),
    }),
  ),
  zValidator(
    "json",
    z.object({
      visibility: AccountVisibility,
    }),
  ),
  async (c) => {
    const body = c.req.valid("json");
    const res = await updateUserVisibility(
      db(),
      fetchDBUserByUid,
      updateDBUser,
    )(getAUthUser(c), c.req.valid("param").userId, body.visibility);

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(res.value);
  },
);

app.delete(
  "/:userId",
  usersRoute.deleteUser,
  zValidator(
    "param",
    z.object({
      userId: z.string().min(1),
    }),
  ),
  async (c) => {
    const res = await deleteUser(
      db(),
      fetchDBUserByUid,
      deleteDBUser,
      deleteAuthUser,
    )(getAUthUser(c));

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(null, 200);
  },
);

export default app;
