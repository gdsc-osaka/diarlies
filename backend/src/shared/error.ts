import { ZodType, ZodTypeDef } from "zod/lib/types";

type BaseTag = string;
type BaseExtra = object;

type BaseError<Tag extends BaseTag, Extra extends BaseExtra> = {
  _tag: Tag;
  message: string;
  stack: string;
  cause?: unknown;
  extra?: Extra;
};

type ErrorOptions<Extra extends BaseExtra> = {
  cause?: unknown;
} & ([Extra] extends [never] ? { extra?: Extra } : { extra: Extra });

type ErrorBuilder<Tag extends BaseTag, Extra extends BaseExtra> = {
  handle: (error: unknown) => BaseError<Tag, Extra>;
  is: { _tag: Tag };
} & ([Extra] extends [never]
  ? {
      (message: string, options?: ErrorOptions<Extra>): BaseError<Tag, Extra>;
    }
    // Extra が指定されていたら options で extra を設定しないとコンパイルエラーにする
  : {
      (message: string, options: ErrorOptions<Extra>): BaseError<Tag, Extra>;
    });

export type InferError<
  Builder extends { handle: (error: unknown) => BaseError<BaseTag, BaseExtra> },
> = ReturnType<Builder["handle"]>;

export const errorBuilder = <
  Tag extends BaseTag,
  Extra extends ZodType<Output, Def, Input> | undefined = undefined,
  Output extends object = object,
  Def extends ZodTypeDef = ZodTypeDef,
  Input = Output,
  ActualExtra extends object = Extra extends ZodType<Output, Def, Input>
    ? Extra["_output"]
    : never,
>(
  tag: Tag,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  extraSchema?: Extra,
): ErrorBuilder<Tag, ActualExtra> =>
  Object.assign(
    (
      message: string,
      options?: ErrorOptions<ActualExtra>,
    ): BaseError<Tag, ActualExtra> => {
      return {
        _tag: tag,
        message: message,
        stack: new Error().stack ?? "",
        cause: options?.cause,
        extra: options?.extra,
      };
    },
    {
      handle: (error: unknown): BaseError<Tag, ActualExtra> => {
        if (error instanceof Error) {
          return {
            _tag: tag,
            message: error.message,
            stack: new Error().stack ?? "",
            cause: error,
          };
        }

        return {
          _tag: tag,
          message: "An unknown error occurred",
          stack: new Error().stack ?? "",
          cause: error,
        };
      },
      is: {
        _tag: tag,
      },
    },
  );
