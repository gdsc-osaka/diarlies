import { errorBuilder, ErrorType } from "../shared/error";

export const DBDiaryNotFoundError = errorBuilder("DBDiaryNotFoundError");
export type DBDiaryNotFoundError = ErrorType<typeof DBDiaryNotFoundError>;

export const DBDiaryAlreadyExistsError = errorBuilder(
  "DBDiaryAlreadyExistsError",
);
export type DBDiaryAlreadyExistsError = ErrorType<
  typeof DBDiaryAlreadyExistsError
>;
