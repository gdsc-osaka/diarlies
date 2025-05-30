import { FileBucket, FileData, FilePath } from "../domain/storage";
import { ResultAsync } from "neverthrow";
import { infraLogger } from "../logger";
import { StorageError } from "./storage-repo.error";

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
      StorageError.handle,
    )
      .andTee((url) => infraLogger("uploadFile").info({ url }))
      .orTee(infraLogger("uploadFile").error);

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
    StorageError.handle,
  ).orTee(infraLogger("getDownloadUrl").error);
