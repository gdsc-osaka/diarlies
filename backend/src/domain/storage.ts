import { Storage, Bucket } from "@google-cloud/storage";
import { DBUser } from "./user";
import env from "../env";

export type FileBucket = InstanceType<typeof Bucket>;

export interface FileData {
  buffer: Buffer;
  owner: string;
  fileName: string;
}

export interface FilePath {
  owner: string;
  fileName: string;
}

export const thumbnailStorageBucket = () =>
  new Storage({
    projectId: 'diarlies',
    credentials: JSON.parse(env.STORAGE_CREDENTIALS)
  }).bucket("diary-thumbnails");

export const fileData = (
  dbUser: DBUser,
  fileName: string,
  buffer: Buffer,
): FileData => ({
  buffer,
  owner: dbUser.id,
  fileName,
});

export const filePath = (dbUser: DBUser, fileName: string): FilePath => ({
  owner: dbUser.id,
  fileName,
});
