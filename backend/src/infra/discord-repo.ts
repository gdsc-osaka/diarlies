import { errAsync, okAsync, ResultAsync } from "neverthrow";
import env from "../env";
import { infraLogger } from "../logger";
import { DiscordError } from "./discord-repo.error";

export type SendDiscordMessage = (
  message: string,
) => ResultAsync<void, DiscordError>;

export const sendDiscordMessage: SendDiscordMessage = (message) =>
  ResultAsync.fromPromise(
    fetch(env.DISCORD_WEBHOOK_URL, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ content: message }),
    }),
    DiscordError.handle,
  )
    .andThen((res) =>
      res.ok
        ? okAsync(undefined)
        : errAsync(
            DiscordError(`Failed to send discord webhook. (${res.status})`),
          ),
    )
    .orTee(infraLogger("sendDiscordMessage").error);
