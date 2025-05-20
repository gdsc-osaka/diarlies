import { Hono } from "hono";
import { fetchDiaryByDate } from "../service/diary-service";
import db from "../db/db";
import { fetchDBUserByUid } from "../infra/user-repository";
import { fetchDBDiaryByDate } from "../infra/diary-repository";
import { getAUthUser } from "./middleware/authorize";
import {
  createServiceError,
  StatusCode,
  toHTTPException,
} from "../service/error/service-error";
import { getDownloadUrl } from "../infra/storage-repository";
import usersDiariesRoute from "./users-diaries.route";

const app = new Hono();

app.get("/", usersDiariesRoute.getDiariesByUser, async (c) => {
  const dateParam = c.req.query("date");

  if (dateParam) {
    // FIXME: path param の userId に対応する Diary を取得するようにする
    const res = await fetchDiaryByDate(
      db(),
      fetchDBUserByUid,
      fetchDBDiaryByDate,
      getDownloadUrl,
    )(getAUthUser(c), new Date(dateParam));

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json([res.value]);
  }

  throw toHTTPException(
    createServiceError(
      StatusCode.BadRequest,
      "At least date is required",
      "invalid_request",
    ),
  );
});

export default app;
