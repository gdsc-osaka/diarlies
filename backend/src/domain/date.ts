import z from "zod";

export const Date = z
  .object({
    year: z.number().int(),
    month: z.number().int(),
    day: z.number().int(),
  })
  .openapi({ ref: "Date" });
export type Date = z.infer<typeof Date>;
