import { errorBuilder, InferError } from "../shared/error";

export const AIError = errorBuilder("AIError");
export type AIError = InferError<typeof AIError>;
