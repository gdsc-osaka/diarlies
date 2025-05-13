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
) => ResultAsync<GenerateContentStreamResponse, AIError>;

export const generateContent =
  (ai: GenAI): GenerateContent =>
  (prompt) =>
    ResultAsync.fromPromise(
      ai.models.generateContent({
        model: "gemini-2.0-flash-preview-image-generation",
        contents: prompt,
        config: {
          responseModalities: ["text", "image"],
        },
      }),
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
