import { ok, Result } from "neverthrow";
import z from "zod";
import "zod-openapi/extend";

export const Timestamp = z
  .object({
    seconds: z.number().int(),
    nanoseconds: z.number().int(),
  })
  .openapi({ ref: "Timestamp" });
export type Timestamp = z.infer<typeof Timestamp>;

export const toTimestamp = (date: Date): Result<Timestamp, never> => {
  return ok({
    seconds: Math.floor(date.getTime() / 1000),
    nanoseconds: (date.getTime() % 1000) * 1_000_000,
  });
};
