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
  return `日記を生成してください。
* 以下のルールに従ってください
  * 日記の言語: ${languageCode}
  * 日記の内容に合わせて絵を生成する
    * 文字を絵の中に含むことを禁止する
    * 画材は色鉛筆または水彩画を使用する
  * 以下のフォーマットで出力する
\`\`\`yaml
# Thinking process
(思考過程)

# Diary entry
(日記の内容)
\`\`\`
* 以下の情報をもとに日記を生成してください
  * 今日行った場所
${locationHistories.map(formatLocationHistory("    ")).join("\n")}
  * 今日の出来事
    * ${memo}
  * 今日の感情: 7 (1-10)
`;
};

export const trimSystemPrompt = (
  generated: GeneratedContent,
): Result<GeneratedContent, never> => {
  return ok({
    text: generated.text.split("# Diary entry").at(-1)?.trim() ?? "",
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
