type BaseTag = string;

type BaseError<Tag extends BaseTag> = {
  _tag: Tag;
  message: string;
  cause?: unknown;
  extra?: Record<string, unknown>;
};

interface ErrorOptions {
  cause?: unknown;
  extra?: Record<string, unknown>;
}
type ErrorBuilder<Tag extends BaseTag> = {
  (message: string, options?: ErrorOptions): BaseError<Tag>;
  handle: (error: unknown) => BaseError<Tag>;
  is: Pick<BaseError<Tag>, "_tag">;
};

export type InferError<Builder extends ErrorBuilder<BaseTag>> = ReturnType<
  Builder["handle"]
>;

export const errorBuilder = <Tag extends BaseTag>(
  tag: Tag,
): ErrorBuilder<Tag> =>
  Object.assign(
    (message: string, options?: ErrorOptions): BaseError<Tag> => {
      return {
        _tag: tag,
        message: message,
        cause: options?.cause,
        extra: options?.extra,
      };
    },
    {
      handle: (error: unknown): BaseError<Tag> => {
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
