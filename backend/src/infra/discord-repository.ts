import { errAsync, okAsync, ResultAsync } from "neverthrow";
import {
  createDiscordError,
  DiscordError,
  handleDiscordError,
} from "./error/discord-error";
import env from "../env";
import { infraLogger } from "../logger";

export type SendDiscordMessage = (
  message: string,
) => ResultAsync<void, DiscordError<"unknown">>;

export const sendDiscordMessage: SendDiscordMessage = (message) =>
  ResultAsync.fromPromise(
    fetch(env.DISCORD_WEBHOOK_URL, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ content: message }),
    }),
    handleDiscordError,
  )
    .andThen((res) =>
      res.ok
        ? okAsync(undefined)
        : errAsync(
            createDiscordError(
              "unknown",
              `Failed to send discord webhook. (${res.status})`,
              undefined,
            ),
          ),
    )
    .orTee(infraLogger("sendDiscordMessage").error);
