import {users} from "../db/schema/users";
import z from "zod";
import "zod-openapi/extend";
import {err, ok, Result} from "neverthrow";
import {Timestamp, toTimestamp} from "./timestamp";
import {AuthUser} from "./auth";
import {ForUpdate} from "./shared/types";

export const AccountVisibility = z.enum(["private", "public"])
    .openapi({ref: "AccountVisibility"});
export type AccountVisibility = z.infer<typeof AccountVisibility>;

export const User = z
    .object({
        id: z.string(),
        uid: z.string(),
        createdAt: Timestamp,
        updatedAt: Timestamp,
    })
    .openapi({ref: "User"});
export type User = z.infer<typeof User>;

export type DBUser = typeof users.$inferSelect;
export type DBUserForCreate = typeof users.$inferInsert;
export type DBUserForUpdate = ForUpdate<DBUser>;

export const convertToUser = (user: DBUser): Result<User, never> => {
    // TODO: validate user with zod
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

export const createDBUserForCreate = (
    authUser: NonNullable<AuthUser>,
): Result<DBUserForCreate, never> => {
    return ok({
        uid: authUser.uid,
    });
};

export const updateDBUserVisibility = (
    user: DBUser,
    visibility: AccountVisibility,
): Result<DBUserForUpdate, never> => {
    return ok({
        id: user.id,
        visibility,
    });
}

export const isSameUser = (dbUser: DBUser, authUser: AuthUser): Result<DBUser, 'wrong-user'> => {
    if (dbUser.uid !== authUser.uid) {
        return err('wrong-user');
    }

    return ok(dbUser);
}