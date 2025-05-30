import { errorBuilder, ErrorType } from "../shared/error";

export const AIError = errorBuilder("AIError");
export type AIError = ErrorType<typeof AIError>;
