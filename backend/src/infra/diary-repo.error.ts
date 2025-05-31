import { errorBuilder, InferError } from "../shared/error";
import z from "zod";

export const DBDiaryNotFoundError = errorBuilder(
  "DBDiaryNotFoundError",
  z.union([
    z.object({
      date: z.instanceof(Date),
      userId: z.string(),
    }),
    z.object({
      diaryId: z.string(),
    }),
  ]),
);
export type DBDiaryNotFoundError = InferError<typeof DBDiaryNotFoundError>;

export const DBDiaryAlreadyExistsError = errorBuilder(
  "DBDiaryAlreadyExistsError",
  z.object({
    diaryDate: z.instanceof(Date),
    userId: z.string(),
  }),
);
export type DBDiaryAlreadyExistsError = InferError<
  typeof DBDiaryAlreadyExistsError
>;
