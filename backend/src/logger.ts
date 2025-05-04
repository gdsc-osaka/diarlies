import { Configuration, configure, getLogger } from "log4js";
import env from "./env";

const log4jsConfig: Configuration = {
  appenders: {
    console: {
      type: "console",
      layout: {
        // 本番環境は Cloud Run のためそのまま出力
        type: "colored",
      },
    },
    application: {
      type: "dateFile",
      filename: "log/application.log",
      pattern: ".yyyyMMdd-hhmmss",
      keepFileExt: true,
      numBackups: 5,
    },
    access: {
      type: "dateFile",
      filename: "log/access.log",
      pattern: ".yyyyMMdd-hhmmss",
      keepFileExt: true,
      numBackups: 5,
    },
  },
  categories: {
    default: {
      appenders: ["console"],
      level: "DEBUG",
    },
    application: {
      appenders: ["console", "application"],
      level: "DEBUG",
      enableCallStack: true,
    },
    access: {
      appenders: ["console", "access"],
      level: "DEBUG",
      enableCallStack: true,
    },
  },
};

// Cloud Logging severities. See https://cloud.google.com/logging/docs/reference/v2/rest/v2/LogEntry#logseverity
type Severity =
  | "DEBUG"
  | "INFO"
  | "NOTICE"
  | "WARNING"
  | "ERROR"
  | "CRITICAL"
  | "ALERT"
  | "EMERGENCY";

class GCloudLogger {
  readonly category: string;

  constructor(category: string) {
    this.category = category.toUpperCase();
  }

  private isObject(value: unknown): value is object {
    return typeof value === "object";
  }

  private format(
    severity: Severity,
    message: unknown,
    ...args: unknown[]
  ): string {
    const msg =
      `[${this.category}] ${message} ${args.filter((arg) => !this.isObject(arg)).join(" ")}`.trimEnd();

    // args is like [{error: new Error(), user: {id: 1, name: "John Doe"}}]
    const entries = args.filter(this.isObject).reduce(
      (acc, arg) => ({
        ...acc,
        ...Object.entries(arg).reduce(
          (acc, [k, v]) => ({
            ...acc,
            // if v is an Error, JSON.stringify(v) returns "{}" so we need to extract the properties
            [k]:
              v instanceof Error
                ? {
                    name: v.name,
                    message: v.message,
                    details: { ...v },
                    stack: v.stack,
                  }
                : v,
          }),
          {},
        ),
      }),
      { message: msg, severity },
    );

    return JSON.stringify(entries);
  }

  debug(message: unknown, ...args: unknown[]): void {
    console.debug(this.format("DEBUG", message, ...args));
  }

  info(message: unknown, ...args: unknown[]): void {
    console.info(this.format("INFO", message, ...args));
  }

  warn(message: unknown, ...args: unknown[]): void {
    console.warn(this.format("WARNING", message, ...args));
  }

  error(message: unknown, ...args: unknown[]): void {
    const _args =
      message instanceof Error
        ? [...args, { error: message, callstack: new Stacktrace().stack }]
        : [...args];
    console.error(this.format("ERROR", message, ..._args));
  }

  trace(message: unknown, ...args: unknown[]): void {
    console.trace(this.format("DEBUG", message, ...args));
  }

  fatal(message: unknown, ...args: unknown[]): void {
    console.error(this.format("CRITICAL", message, ...args));
  }

  mark(message: unknown, ...args: unknown[]): void {
    console.log(this.format("INFO", message, ...args));
  }
}

class Stacktrace extends Error {
  static {
    this.prototype.name = "Stacktrace";
  }
}

configure(log4jsConfig);

const isProduction = env.NODE_ENV === "production";
// export const logger = isProduction ? new GCloudLogger('default') : getLogger();
export const appLogger = isProduction
  ? new GCloudLogger("app")
  : getLogger("application");
export const accessLogger = isProduction
  ? new GCloudLogger("access")
  : getLogger("access");
