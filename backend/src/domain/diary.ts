import z from "zod";
import { Timestamp, toTimestamp } from "./timestamp";
import { Day } from "./day";
import { diaries } from "../db/schema/diaries";
import { err, ok, Result } from "neverthrow";
import { convertToUser, DBUser, User } from "./user";
import cuid2 from "@paralleldrive/cuid2";
import { GeneratedContent } from "./ai";

export const Diary = z
  .object({
    id: z.string(),
    content: z.string(),
    diaryDate: Day,
    thumbnailUrl: z.string(),
    createdAt: Timestamp,
    updatedAt: Timestamp,
  })
  .openapi({ ref: "Diary" });
export type Diary = z.infer<typeof Diary>;

export const DiaryWithUser = Diary.extend({
  user: User,
}).openapi({ ref: "DiaryWithUser" });
export type DiaryWithUser = z.infer<typeof DiaryWithUser>;

export type DBDiary = typeof diaries.$inferSelect;
export type DBDiaryForCreate = typeof diaries.$inferInsert;
export type DBDiaryWithDBUser = DBDiary & {
  user: DBUser;
};

export const dbDiaryForCreate = (
  userId: string,
  generated: GeneratedContent,
): Result<DBDiaryForCreate, never> => {
  return ok({
    userId,
    content: generated.text,
    // TODO: diaryDate should be passed from the client
    diaryDate: new Date(),
    thumbnailPath: generated.image ? cuid2.createId() : "/not-found.png",
  });
};

export const convertToDiary = (
  dbDiary: DBDiary,
  thumbnailUrl?: string,
): Result<Diary, never> => {
  return Result.combine([
    toTimestamp(dbDiary.createdAt),
    toTimestamp(dbDiary.updatedAt),
  ]).map(([createdAt, updatedAt]) => ({
    id: dbDiary.id,
    content: dbDiary.content,
    diaryDate: {
      year: dbDiary.diaryDate.getFullYear(),
      month: dbDiary.diaryDate.getMonth() + 1,
      day: dbDiary.diaryDate.getDate(),
    },
    thumbnailUrl: thumbnailUrl ?? "https://i.ibb.co/sdKR9d57/cake.png",
    createdAt,
    updatedAt,
  }));
};

export const convertToDiaryWithUser = (
  dbDiary: DBDiaryWithDBUser,
  thumbnailUrl?: string,
): Result<DiaryWithUser, never> => {
  return Result.combine([
    convertToUser(dbDiary.user),
    convertToDiary(dbDiary, thumbnailUrl),
  ]).map(([user, diary]) => ({
    ...diary,
    user,
  }));
};

export const isDBDiaryOwnedByUser = (
  dbDiary: DBDiary,
  user: DBUser,
): Result<true, "diary_not_owned_by_user"> => {
  if (dbDiary.userId === user.id) {
    return ok(true);
  } else {
    return err("diary_not_owned_by_user");
  }
};
