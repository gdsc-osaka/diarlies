import {type} from "arktype";
import {ok, Result} from "neverthrow";

export const Timestamp = type({
    seconds: "number % 1", // integer
    nanoseconds: "number % 1", // integer
});

export type Timestamp = typeof Timestamp.infer;

export const toTimestamp = (date: Date): Result<Timestamp, never> => {
    return ok({
        seconds: Math.floor(date.getTime() / 1000),
        nanoseconds: (date.getTime() % 1000) * 1_000_000,
    });
}