import { GoogleGenAI } from "@google/genai";
import { MapPlace } from "./map";
import { LanguageCode } from "./language";

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
  memo: string,
): string => {
  return `あなたは私の"日記生成アシスタント"です。
1. 以下の情報を基に、今日1日を振り返る日記を作成してください。
2. 日記の言語: ${languageCode}
3. 日記の内容に合わせて, 色鉛筆で描いた絵を生成してください。ただし, 文字を絵の中に含むことは禁止します。

# 今日行った場所
${locationHistories.map(formatLocationHistory).join("\n")}

# 今日の出来事
今日の感情を1(悲しい)~10(幸せ)の数字で表すと7でした。(この数値は日記には記載しないこと)
感情の理由: ${memo}
`;
};

const formatLocationHistory = (location: LocationHistory): string => {
  return (
    `- ${formatDate(location.visitedAt)}: \n` +
    location.places
      .map((place) => `  - ${place.displayName} (${place.address})`)
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
