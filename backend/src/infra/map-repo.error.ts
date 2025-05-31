import { errorBuilder, InferError } from "../shared/error";

export const MapError = errorBuilder("MapError");
export type MapError = InferError<typeof MapError>;
