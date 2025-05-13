import { Hono } from "hono";
import { describeRoute } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import { Diary } from "../domain/diary";
import { zValidator } from "@hono/zod-validator";
import { createDiary, CreateDiaryRequest } from "../service/diary-service";
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
  createDBDiaryGenerationJob,
  updateDBDiaryGenerationJob,
} from "../infra/diary-generation-job-repository";
import { createMapPlaceClient } from "../domain/map";

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
                type: "string",
                enum: LanguageCode.options,
                description: "Language code for diary generation",
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
            required: ["locationHistories", "images"],
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
  zValidator(
    "form",
    z.object({
      locationHistories: z.string(), // JSON string
      languageCode: LanguageCode,
      images: z.array(z.instanceof(File)),
    }),
  ),
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
      fetchNearbyPlaces(createMapPlaceClient(c.env.GOOGLE_MAPS_API_KEY)),
      createDBDiaryGenerationJob,
      updateDBDiaryGenerationJob,
    )(parseResult.data);

    if (res.isErr()) {
      throw toHTTPException(res.error);
    }

    return c.json(res.value, 201);
  },
);

export default app;
