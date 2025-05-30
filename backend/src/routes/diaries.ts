import { Hono } from "hono";
import {
  createDiary,
  CreateDiaryRequest,
  deleteDiary,
  fetchDiariesByDuration,
  reportInappropriateDiary,
} from "../service/diary-service";
import {
  createServiceError,
  StatusCode,
  toHTTPException,
} from "../service/error/service-error";
import { LanguageCode } from "../domain/language";
import db from "../db/db";
import { fetchNearbyPlaces } from "../infra/map-repo";
import {
  createDBDiary,
  deleteDBDiary,
  fetchDBDiariesByDuration,
  fetchDBDiaryById,
} from "../infra/diary-repo";
import { fetchDBUserByUid } from "../infra/user-repo";
import { generateContent } from "../infra/ai-repo";
import { createMapPlaceClient } from "../domain/map";
import { createGenAI } from "../domain/ai";
import env from "../env";
import { getAUthUser } from "./middleware/authorize";
import { getDownloadUrl, uploadFile } from "../infra/storage-repo";
import diariesRoute from "./diaries.route";
import { sendDiscordMessage } from "../infra/discord-repo";
import { zValidator } from "@hono/zod-validator";
import z from "zod";
import { createDiaryController } from "../controller/diary-controller";

type Bindings = {
  GEMINI_API_KEY: string;
  GOOGLE_MAPS_API_KEY: string;
};

const app = new Hono<{ Bindings: Bindings }>();

app.post(
  "/",
  diariesRoute.createDiary,
  // FIXME: 正常なリクエストでも zValidator がエラーを返す
  // zValidator(
  //   "form",
  //   z.object({
  //     locationHistories: z.string(), // JSON string
  //     languageCode: LanguageCode,
  //     images: z.array(z.instanceof(File)),
  //   }),
  // ),
  async (c) => {
    const form = await c.req.formData();
    // zValidator でバリデーション済みなので、型アサーションを行う
    const locationHistories = form.get("locationHistories") as string;
    const languageCode = form.get("languageCode") as LanguageCode;
    const images = form.getAll("images") as File[];
    const memo = form.get("memo") as string | undefined;

    // Convert json string to object
    const parseResult = await CreateDiaryRequest.safeParseAsync({
      locationHistories: JSON.parse(locationHistories),
      languageCode,
      images,
      memo,
    });
    if (!parseResult.success) {
      throw toHTTPException(
        createServiceError(
          StatusCode.BadRequest,
          "Invalid request",
          "invalid_request",
          {
            errors: parseResult.error.flatten().fieldErrors,
          },
        ),
      );
    }

    const res = await createDiaryController(
      createDiary(
        db(),
        fetchDBUserByUid,
        fetchNearbyPlaces(createMapPlaceClient(env.GOOGLE_MAPS_API_KEY)),
        createDBDiary,
        generateContent(createGenAI(env.GEMINI_API_KEY)),
        uploadFile,
      )(getAUthUser(c), parseResult.data),
    ); // getFirebaseToken(c)!

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(res.value, 201);
  },
);

// GET /diaries?date=2023-10-01
app.get("/", diariesRoute.getDiaries, async (c) => {
  const startDateParam = c.req.query("startDate");
  const endDateParam = c.req.query("endDate");

  if (startDateParam && endDateParam) {
    const startDate = new Date(startDateParam);
    const endDate = new Date(endDateParam);

    if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
      throw toHTTPException(
        createServiceError(
          StatusCode.BadRequest,
          "Invalid date format",
          "invalid_request",
        ),
      );
    }

    const res = await fetchDiariesByDuration(
      db(),
      fetchDBDiariesByDuration,
      getDownloadUrl,
    )(getAUthUser(c), startDate, endDate);

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(res.value);
  }

  throw toHTTPException(
    createServiceError(
      StatusCode.BadRequest,
      "At least date is required",
      "invalid_request",
    ),
  );
});

app.delete("/:diaryId", diariesRoute.deleteDiary, async (c) => {
  const diaryId = c.req.param("diaryId");

  const res = await deleteDiary(
    db(),
    fetchDBUserByUid,
    fetchDBDiaryById,
    deleteDBDiary,
  )(getAUthUser(c), diaryId);

  if (res.isErr()) {
    throw toHTTPException(res.error);
  }

  return c.json(res.value);
});

app.post(
  "/:diaryId/report-inappropriate",
  diariesRoute.reportInappropriateDiary,
  zValidator(
    "json",
    z.object({
      reason: z.string(),
    }),
  ),
  async (c) => {
    const diaryId = c.req.param("diaryId");
    const { reason } = c.req.valid("json");

    const res = await reportInappropriateDiary(
      db(),
      fetchDBUserByUid,
      fetchDBDiaryById,
      sendDiscordMessage,
    )(getAUthUser(c), diaryId, reason);

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.text("Diary reported successfully", 200);
  },
);

export default app;
