import { DBUser } from "../db/schema/users";
import z from "zod";
import "zod-openapi/extend";
import { Result } from "neverthrow";
import { Timestamp, toTimestamp } from "./timestamp";

export const User = z
  .object({
    id: z.string().uuid(),
    uid: z.string(),
    createdAt: Timestamp,
    updatedAt: Timestamp,
  })
  .openapi({ ref: "User" });
export type User = z.infer<typeof User>;

// check if the User type is compatible with DBUser
// const okType: User = {} as User;
// okType satisfies DBUser;

export const convertToUser = (user: DBUser): Result<User, never> => {
  // const out = User(user);
  //
  // if (out instanceof type.errors) {
  //   return err(out);
  // }

  return Result.combine([
    toTimestamp(user.createdAt),
    toTimestamp(user.updatedAt),
  ]).map(([createdAt, updatedAt]) => ({
    id: user.id,
    uid: user.uid,
    createdAt,
    updatedAt,
  }));
};
