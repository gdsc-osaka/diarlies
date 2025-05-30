import { errorBuilder, InferError } from "../shared/error";

export const DBUserNotFoundError = errorBuilder("DBUserNotFoundError");
export type DBUserNotFoundError = InferError<typeof DBUserNotFoundError>;

export const DBUserAlreadyExistsError = errorBuilder(
  "DBUserAlreadyExistsError",
);
export type DBUserAlreadyExistsError = InferError<
  typeof DBUserAlreadyExistsError
>;
