import { describeRoute } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import { Diary, DiaryWithUser } from "../domain/diary";
import z from "zod";

const tags = ["Diaries"];

const createDiary = describeRoute({
  tags,
  validateResponse: true,
  operationId: "createDiary",
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
            memo: {
              type: "string",
              description: "Memo for diary generation",
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
});

const getDiaries = describeRoute({
  tags,
  validateResponse: true,
  operationId: "getDiaries",
  description: "Get diaries",
  parameters: [
    {
      name: "startDate",
      in: "query",
      description: "Start date to filter diaries",
      required: false,
      schema: {
        type: "string",
        format: "date",
      },
    },
    {
      name: "endDate",
      in: "query",
      description: "End date to filter diaries",
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
          schema: resolver(z.array(DiaryWithUser)),
        },
      },
    },
  },
});

const deleteDiary = describeRoute({
  tags,
  validateResponse: true,
  operationId: "deleteDiary",
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
});

const reportInappropriateDiary = describeRoute({
  tags,
  validateResponse: true,
  operationId: "reportInappropriateDiary",
  description: "Report a diary as inappropriate",
  parameters: [
    {
      name: "diaryId",
      in: "path",
      description: "Diary ID to report",
      required: true,
      schema: {
        type: "string",
      },
    },
  ],
  requestBody: {
    content: {
      "application/json": {
        schema: {
          type: "object",
          properties: {
            reason: {
              type: "string",
              description: "Reason for reporting the diary",
            },
          },
          required: ["reason"],
        },
      },
    },
  },
  responses: {
    200: {
      description: "Diary reported successfully",
    },
  },
});

export default {
  createDiary,
  getDiaries,
  deleteDiary,
  reportInappropriateDiary,
};
