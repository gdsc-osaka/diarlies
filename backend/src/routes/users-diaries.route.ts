import { describeRoute } from "hono-openapi";
import { resolver } from "hono-openapi/zod";
import z from "zod";
import { Diary } from "../domain/diary";

const tags = ["Diaries"];

const getDiariesByUser = describeRoute({
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
});

export default {
  getDiariesByUser,
};
