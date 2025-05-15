import z from "zod";

export const Day = z
  .object({
    year: z.number().int(),
    month: z.number().int(),
    day: z.number().int(),
  })
  .openapi({ ref: "Day" });
export type Day = z.infer<typeof Day>;
