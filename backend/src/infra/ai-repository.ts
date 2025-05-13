import { errAsync, okAsync, ResultAsync } from "neverthrow";
import { AIError, createAIError, handleAIError } from "./error/ai-error";
import { infraLogger } from "../logger";
import { GenAI } from "../domain/ai";

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
        const inlineData: {
          inlineData: { data: string; mimeType: string };
        }[] = await Promise.all(
          images.map(async (image) => ({
            inlineData: {
              data: (await image.bytes()).toString(),
              mimeType: image.type,
            },
          })),
        );

        return ai.models.generateContent({
          model: "gemini-2.0-flash-preview-image-generation",
          contents: [prompt, ...inlineData],
          config: {
            responseModalities: ["text", "image"],
          },
        });
      })(),
      handleAIError,
    )
      // .andTee((res) => infraLogger.info(`AI response: ${JSON.stringify(res, null, 2)}`))
      .orTee(infraLogger.error)
      .andThen((res) =>
        res.text === undefined
          ? errAsync(createAIError("unknown", "No text in response", undefined))
          : okAsync({
              text: res.text,
              image: res.data
                ? Buffer.from(res.data, "base64").toString()
                : undefined,
            }),
      );
