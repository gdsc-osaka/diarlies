import { errorBuilder, ErrorType } from "../shared/error";

export const StorageError = errorBuilder("StorageError");
export type StorageError = ErrorType<typeof StorageError>;
