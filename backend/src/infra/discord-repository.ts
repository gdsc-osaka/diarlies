import { errAsync, okAsync, ResultAsync } from "neverthrow";
import {
  createDiscordError,
  DiscordError,
  handleDiscordError,
} from "./error/discord-error";
import env from "../env";

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
      ResultAsync.fromPromise(res.json(), handleDiscordError).andThen((json) =>
        okAsync({
          ok: res.ok,
          status: res.status,
          json: json as unknown,
        }),
      ),
    )
    .andThen((res) =>
      res.ok
        ? okAsync(undefined)
        : errAsync(
            createDiscordError(
              "unknown",
              `Failed to send discord webhook. (${res.status}: ${res.json})`,
              undefined,
            ),
          ),
    );
