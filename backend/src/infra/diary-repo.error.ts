import { errorBuilder, InferError } from "../shared/error";

export const DBDiaryNotFoundError = errorBuilder("DBDiaryNotFoundError");
export type DBDiaryNotFoundError = InferError<typeof DBDiaryNotFoundError>;

export const DBDiaryAlreadyExistsError = errorBuilder(
  "DBDiaryAlreadyExistsError",
);
export type DBDiaryAlreadyExistsError = InferError<
  typeof DBDiaryAlreadyExistsError
>;
