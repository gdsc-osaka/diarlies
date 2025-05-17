// /users/:userId/diaries

import { Hono } from "hono";
import { describeRoute } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import z from "zod";
import { Diary } from "../domain/diary";
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

const app = new Hono();
const tags = ["Diaries"];

app.get(
  "/",
  describeRoute({
    tags,
    validateResponse: true,
    operationId: "getDiariesByUser",
    description: "Get diaries",
    parameters: [
      {
        name: "date",
        in: "query",
        description:
          "Date to filter diaries. startDate and endDate will be ignored if this is provided",
        required: false,
        schema: {
          type: "string",
          format: "date",
        },
      },
    ],
    responses: {
      200: {
        description: "Diaries retrieved successfully",
        content: {
          "application/json": {
            schema: resolver(z.array(Diary)),
          },
        },
      },
    },
  }),
  async (c) => {
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
  },
);

export default app;
