import { errorBuilder, InferError } from "../shared/error";

export const StorageError = errorBuilder("StorageError");
export type StorageError = InferError<typeof StorageError>;
