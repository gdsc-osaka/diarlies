import {ZodType, ZodTypeDef} from "zod/lib/types";

type BaseTag = string;
type BaseExtra = object;

type BaseError<Tag extends BaseTag, Extra extends BaseExtra> = {
  _tag: Tag;
  message: string;
  cause?: unknown;
  extra?: Extra;
};

interface ErrorOptions<Extra extends BaseExtra> {
  cause?: unknown;
  extra?: Extra;
}

type ErrorBuilder<Tag extends BaseTag, Extra extends BaseExtra> = {
  (message: string, options?: ErrorOptions<Extra>): BaseError<Tag, Extra>;
  handle: (error: unknown) => BaseError<Tag, Extra>;
  is: {_tag: Tag };
};

export type InferError<
    Builder extends { handle: (error: unknown) => BaseError<BaseTag, BaseExtra> },
> = ReturnType<Builder["handle"]>;

export const errorBuilder = <
    Tag extends BaseTag,
    Extra extends ZodType<Output, Def, Input> | undefined = undefined,
    Output extends object = object,
    Def extends ZodTypeDef = ZodTypeDef,
    Input = Output,
    ActualExtra extends object = Extra extends ZodType<Output, Def, Input> ? Extra["_output"] : never,
>(
    tag: Tag,
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    _?: Extra,
): ErrorBuilder<Tag, ActualExtra> =>
    Object.assign(
        (
            message: string,
            options?: ErrorOptions<ActualExtra>,
        ): BaseError<Tag, ActualExtra> => {
          return {
            _tag: tag,
            message: message,
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
                cause: error,
              };
            }

            return {
              _tag: tag,
              message: "An unknown error occurred",
              cause: error,
            };
          },
          is: {
            _tag: tag,
          },
        },
    );
