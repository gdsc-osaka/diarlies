import { Hono } from "hono";
import { describeRoute } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import { Diary } from "../domain/diary";
import {
  createDiary,
  CreateDiaryRequest,
  deleteDiary,
  fetchDiaryByDate,
} from "../service/diary-service";
import z from "zod";
import {
  createServiceError,
  StatusCode,
  toHTTPException,
} from "../service/error/service-error";
import { LanguageCode } from "../domain/language";
import db from "../db/db";
import { fetchNearbyPlaces } from "../infra/map-repository";
import {
  createDBDiary,
  deleteDBDiary,
  fetchDBDiaryByDate,
  fetchDBDiaryById,
} from "../infra/diary-repository";
import { fetchDBUserByUid } from "../infra/user-repository";
import { generateContent } from "../infra/ai-repository";
import { createMapPlaceClient } from "../domain/map";
import { createGenAI } from "../domain/ai";
import env from "../env";
import { getAUthUser } from "./middleware/authorize";

type Bindings = {
  GEMINI_API_KEY: string;
  GOOGLE_MAPS_API_KEY: string;
};

const app = new Hono<{ Bindings: Bindings }>();
const tags = ["Diaries"];

app.post(
  "/",
  describeRoute({
    tags,
    validateResponse: true,
    description: "Create a new diary",
    requestBody: {
      content: {
        "multipart/form-data": {
          schema: {
            type: "object",
            properties: {
              locationHistories: {
                type: "string",
                description: "Location histories for diary generation",
              },
              languageCode: {
                $ref: "#/components/schemas/LanguageCode",
              },
              images: {
                type: "array",
                items: {
                  type: "string",
                  format: "binary",
                  description: "Images for diary generation",
                },
              },
            },
            required: ["locationHistories", "images", "languageCode"],
          },
        },
      },
    },
    responses: {
      201: {
        description: "Diary created successfully",
        content: {
          "application/json": {
            schema: resolver(Diary),
          },
        },
      },
    },
  }),
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

    // Convert json string to object
    const parseResult = await CreateDiaryRequest.safeParseAsync({
      locationHistories: JSON.parse(locationHistories),
      languageCode: languageCode,
      images: images,
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

    const res = await createDiary(
      db(),
      fetchDBUserByUid,
      fetchNearbyPlaces(createMapPlaceClient(env.GOOGLE_MAPS_API_KEY)),
      createDBDiary,
      generateContent(createGenAI(env.GEMINI_API_KEY)),
    )(getAUthUser(c), parseResult.data); // getFirebaseToken(c)!

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(res.value, 201);
  },
);

// GET /diaries?date=2023-10-01
app.get(
  "/",
  describeRoute({
    tags,
    validateResponse: true,
    description: "Get diaries",
    parameters: [
      {
        name: "date",
        in: "query",
        description: "Date to filter diaries",
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
      const res = await fetchDiaryByDate(
        db(),
        fetchDBUserByUid,
        fetchDBDiaryByDate,
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

app.delete(
  "/:diaryId",
  describeRoute({
    tags,
    validateResponse: true,
    description: "Delete a diary",
    parameters: [
      {
        name: "diaryId",
        in: "path",
        description: "Diary ID to delete",
        required: true,
        schema: {
          type: "string",
        },
      },
    ],
    responses: {
      200: {
        description: "Diary deleted successfully",
        content: {
          "application/json": {
            schema: resolver(Diary),
          },
        },
      },
    },
  }),
  async (c) => {
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
  },
);

export default app;
