import { errorBuilder, InferError } from "../shared/error";
import z from "zod";

export const DBUserNotFoundError = errorBuilder(
  "DBUserNotFoundError",
  z.union([z.object({ id: z.string() }), z.object({ uid: z.string() })]),
);
export type DBUserNotFoundError = InferError<typeof DBUserNotFoundError>;

export const DBUserAlreadyExistsError = errorBuilder(
  "DBUserAlreadyExistsError",
  z.object({ uid: z.string() }),
);
export type DBUserAlreadyExistsError = InferError<
  typeof DBUserAlreadyExistsError
>;
