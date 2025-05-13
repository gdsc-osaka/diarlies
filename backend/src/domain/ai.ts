import { GoogleGenAI } from "@google/genai";

export type GenAI = InstanceType<typeof GoogleGenAI>;

export const createGenAI = (apiKey: string): GenAI => {
  return new GoogleGenAI({
    apiKey,
  });
};
