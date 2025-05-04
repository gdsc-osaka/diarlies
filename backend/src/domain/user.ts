import {type} from "arktype";
import {DBUser} from "../db/schema/users";
import {ok, Result} from "neverthrow";
import {Timestamp, toTimestamp} from "./timestamp";

export const User = type({
    id: "string.uuid.v7",
    uid: "string",
    createdAt: Timestamp,
    updatedAt: Timestamp,
});
export type User = typeof User.infer;

// check if the User type is compatible with DBUser
// const okType: User = {} as User;
// okType satisfies DBUser;

export const convertUser = (user: DBUser): Result<User, never> => {
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
