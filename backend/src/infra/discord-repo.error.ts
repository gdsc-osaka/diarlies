import { errorBuilder, InferError } from "../shared/error";

export const DiscordError = errorBuilder("DiscordError");
export type DiscordError = InferError<typeof DiscordError>;
