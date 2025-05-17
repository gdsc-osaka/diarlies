import { FileData, FileBucket, FilePath } from "../domain/storage";
import { ResultAsync } from "neverthrow";
import { handleStorageError, StorageError } from "./error/storage-error";
import { infraLogger } from "../logger";

export type UploadFile = (
  bucket: FileBucket,
) => (file: FileData) => ResultAsync<string, StorageError>;

export const uploadFile: UploadFile =
  (bucket: FileBucket) => (fileData: FileData) =>
    ResultAsync.fromPromise(
      (async () => {
        const file = bucket.file(`${fileData.owner}/${fileData.fileName}`);
        await file.save(fileData.buffer);
        const [url] = await file.getSignedUrl({
          version: "v4",
          action: "read",
          expires: Date.now() + 60 * 60 * 1000, // 1 hour
        });
        return url;
      })(),
      handleStorageError,
    ).orTee(infraLogger.error);

export type GetDownloadUrl = (
  bucket: FileBucket,
) => (filePatH: FilePath) => ResultAsync<string, StorageError>;

export const getDownloadUrl = (bucket: FileBucket) => (filePath: FilePath) =>
  ResultAsync.fromPromise(
    (async () => {
      const file = bucket.file(`${filePath.owner}/${filePath.fileName}`);
      const [url] = await file.getSignedUrl({
        version: "v4",
        action: "read",
        expires: Date.now() + 60 * 60 * 1000, // 1 hour
      });
      return url;
    })(),
    handleStorageError,
  ).orTee(infraLogger.error);
