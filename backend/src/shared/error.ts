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
>(
    tag: Tag,
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    _?: Extra,
): ErrorBuilder<Tag, Extra extends ZodType<Output, Def, Input> ? Extra["_output"] : never> =>
    Object.assign(
        (
            message: string,
            options?: ErrorOptions<Extra extends ZodType<Output, Def, Input> ? Extra["_output"] : never>,
        ): BaseError<Tag, Extra extends ZodType<Output, Def, Input> ? Extra["_output"] : never> => {
          if (_ === undefined) {
            return {
              _tag: tag,
              message: message,
              cause: options?.cause,
            };
          }
          return {
            _tag: tag,
            message: message,
            cause: options?.cause,
            extra: options?.extra,
          };
        },
        {
          handle: (error: unknown): BaseError<Tag, Extra extends ZodType<Output, Def, Input> ? Extra["_output"] : never> => {
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
