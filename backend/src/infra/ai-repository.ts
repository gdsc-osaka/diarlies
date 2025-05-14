import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { AIError, createAIError, handleAIError } from "./error/ai-error";
import { infraLogger } from "../logger";
import { GenAI } from "../domain/ai";
import { Modality } from "@google/genai";

interface GenerateContentStreamResponse {
  text: string;
  image?: string;
}

export type GenerateContent = (
  prompt: string,
  images: File[],
) => ResultAsync<GenerateContentStreamResponse, AIError>;

export const generateContent =
  (ai: GenAI): GenerateContent =>
  (prompt, images) =>
    ResultAsync.fromPromise(
      (async () => {
        const inlineData = await Promise.all(
          images.map(async (image) => ({
            inlineData: {
              data: Buffer.from(await image.arrayBuffer()).toString("base64"),
              mimeType: image.type,
            },
          })),
        );

        const result = await ai.models.generateContent({
          model: "gemini-2.0-flash-preview-image-generation",
          contents: [prompt, ...inlineData],
          config: {
            responseModalities: [Modality.TEXT, Modality.IMAGE],
          },
        });
        const parts = result.candidates?.at(0)?.content?.parts;

        if (!parts) {
          throw new Error("No candidates in response");
        }

        const image = parts.filter((part) => part.inlineData).at(0)?.inlineData;
        const text = parts
          .filter((part) => part.text)
          .map((part) => part.text)
          .join("\n");

        return {
          text,
          image: image?.data
            ? Buffer.from(image.data, "base64").toString()
            : undefined,
        };
      })(),
      handleAIError,
    )
      // .andTee((res) => infraLogger.info(`AI response: ${JSON.stringify(res, null, 2)}`))
      .orTee(infraLogger.error);
