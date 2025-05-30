import { errorBuilder, ErrorType } from "../shared/error";

export const MapError = errorBuilder("MapError");
export type MapError = ErrorType<typeof MapError>;
