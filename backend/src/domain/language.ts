import z from "zod";

export const LanguageCode = z.enum(["ja", "en", "ko", "zh", "fr", "es"]);
export type LanguageCode = z.infer<typeof LanguageCode>;
