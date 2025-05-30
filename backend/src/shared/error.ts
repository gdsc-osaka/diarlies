import { ZodType, ZodTypeDef } from "zod/lib/types";

type BaseTag = string;
type BaseExtra = object;
type Extra<E extends BaseExtra> = [E] extends [never]
  ? { extra?: E }
  : { extra: E };

const TAG: unique symbol = Symbol("TAG");

type BaseError<Tag extends BaseTag, Ext extends BaseExtra> = {
  [TAG]: Tag;
  message: string;
  stack: string;
  cause?: unknown;
  extra?: Ext;
};

type ErrorOptions<Ext extends BaseExtra> = {
  cause?: unknown;
} & Extra<Ext>;

type ErrorBuilder<Tag extends BaseTag, Extra extends BaseExtra> = {
  handle: (error: unknown) => BaseError<Tag, Extra>;
  is: { [TAG]: Tag };
} & ([Extra] extends [never]
  ? {
      (message: string, options?: ErrorOptions<Extra>): BaseError<Tag, Extra>;
    }
  : // Extra が指定されていたら options で extra を設定しないとコンパイルエラーにする
    {
      (message: string, options: ErrorOptions<Extra>): BaseError<Tag, Extra>;
    });

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export type InferError<Builder extends ErrorBuilder<any, any>> =
  ReturnType<Builder>;

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

  extraSchema?: Extra,
): ErrorBuilder<Tag, ActualExtra> =>
  Object.assign(
    (
      message: string,
      options?: ErrorOptions<ActualExtra>,
    ): BaseError<Tag, ActualExtra> => {
      return {
        [TAG]: tag,
        message: message,
        stack: replaceErrorName(new Error().stack, tag),
        cause: options?.cause,
        extra: options?.extra,
      };
    },
    {
      handle: (error: unknown): BaseError<Tag, ActualExtra> => {
        if (error instanceof Error) {
          return {
            [TAG]: tag,
            message: error.message,
            stack: replaceErrorName(new Error().stack, tag),
            cause: error,
          };
        }

        return {
          [TAG]: tag,
          message: "An unknown error occurred",
          stack: replaceErrorName(new Error().stack, tag),
          cause: error,
        };
      },
      is: {
        [TAG]: tag,
      },
      zod: extraSchema,
    },
  );

function replaceErrorName(stack: string | undefined, name: string): string {
  return stack?.replace(/Error/g, name) ?? "";
}
