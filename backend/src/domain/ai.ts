import { GoogleGenAI } from "@google/genai";
import { MapPlace } from "./map";
import { LanguageCode } from "./language";
import { ok, Result } from "neverthrow";

export type GenAI = InstanceType<typeof GoogleGenAI>;

export const createGenAI = (apiKey: string): GenAI => {
  if (!apiKey || apiKey.length === 0) {
    throw new Error("GenAI API key is empty");
  }

  return new GoogleGenAI({
    apiKey,
  });
};

interface LocationHistory {
  places: MapPlace[];
  visitedAt: Date;
}

// 3. 文字列の出力は日記の内容のみとしてください。
export const diaryGenerationPrompt = (
  locationHistories: LocationHistory[],
  languageCode: LanguageCode,
  memo?: string,
): string => {
  return `You are an AI assistant tasked with generating a diary entry and an accompanying illustration concept.

## Task
Generate a diary entry based on the provided information. Also, describe an illustration concept that visually represents the diary entry.

## Rules & Constraints

1.  **Diary Language:**
    * The diary entry must be written in: ${languageCode}

2.  **Illustration Details:**
    * The illustration concept should visually depict the events or mood of the diary entry.
    * **Critical:** The illustration MUST NOT contain any text, letters, or numbers.
    * **Art Medium:** The style for the conceptual illustration should be exclusively colored pencil OR watercolor.

3.  **Output Format:**
    * Strictly adhere to the following YAML format.
    * The "Thinking process" should briefly explain your reasoning for the diary content and the image concept.
    * Do not include quote sentences (>) in the YAML output.

\`\`\`yaml
# Thinking process
> This section should outline:
> 1. Your reasoning for the diary entry's content and tone.
> 2. A detailed description of the illustration concept, including composition, key elements, and how it relates to the diary.
>    Remember the art medium (colored pencil or watercolor) and the no-text constraint for the image.

# Diary entry
> [Content of the diary entry in ${languageCode}]
\`\`\`

## Input Information
Use the following details to generate the diary and illustration concept:

* **Places Visited Today:**
${locationHistories.map(formatLocationHistory("    ")).join("\n")}

* **Today's Key Events/Memo:**
${memo ?? "No specific events or memos provided."}

* **Today's Overall Emotion (1-10 scale, where 1 = very negative, 10 = very positive):**
7
`;
};

export const trimSystemPrompt = (
  generated: GeneratedContent,
): Result<GeneratedContent, never> => {
  return ok({
    text: generated.text.split("# Diary entry").at(1)?.trim() ?? "",
    image: generated.image,
  });
};

const formatLocationHistory =
  (indent: string) =>
  (location: LocationHistory): string => {
    return (
      `- ${formatDate(location.visitedAt)}: \n` +
      location.places
        .map((place) => `${indent}* ${place.displayName} (${place.address})`)
        .join("\n")
    );
  };

const formatDate = (date: Date): string => {
  // yyyy/MM/dd hh:mm
  const yyyy = date.getFullYear();
  const MM = String(date.getMonth() + 1).padStart(2, "0");
  const dd = String(date.getDate()).padStart(2, "0");
  const hh = String(date.getHours()).padStart(2, "0");
  const mm = String(date.getMinutes()).padStart(2, "0");
  return `${yyyy}/${MM}/${dd} ${hh}:${mm}`;
};

export interface GeneratedContent {
  text: string;
  image?: Buffer<ArrayBuffer>;
}
