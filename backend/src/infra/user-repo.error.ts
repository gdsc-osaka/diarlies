import { errorBuilder, ErrorType } from "../shared/error";

export const DBUserNotFoundError = errorBuilder("DBUserNotFoundError");
export type DBUserNotFoundError = ErrorType<typeof DBUserNotFoundError>;

export const DBUserAlreadyExistsError = errorBuilder(
  "DBUserAlreadyExistsError",
);
export type DBUserAlreadyExistsError = ErrorType<
  typeof DBUserAlreadyExistsError
>;
