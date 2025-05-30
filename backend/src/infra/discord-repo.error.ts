import { errorBuilder, ErrorType } from "../shared/error";

export const DiscordError = errorBuilder("DiscordError");
export type DiscordError = ErrorType<typeof DiscordError>;
