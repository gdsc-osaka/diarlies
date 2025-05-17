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
    infra: {
      type: "dateFile",
      filename: "log/infra.log",
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
    service: {
      type: "dateFile",
      filename: "log/application.log",
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

const formatGCloudMessage = (
  category: string,
  severity: Severity,
  label: string,
  message: unknown,
  ...args: unknown[]
): string => {
  const msg =
    `[${category}] ${label} - ${message} ${args.filter((arg) => typeof arg !== "object").join(" ")}`.trimEnd();

  // args is like [{error: new Error(), user: {id: 1, name: "John Doe"}}]
  const entries = args
    .filter((arg) => typeof arg === "object" && arg !== null)
    .reduce(
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
};

type Logger = {
  debug: (message: unknown, ...args: unknown[]) => void;
  info: (message: unknown, ...args: unknown[]) => void;
  warn: (message: unknown, ...args: unknown[]) => void;
  error: (message: unknown, ...args: unknown[]) => void;
};
type LoggerBuilder = (label: string) => Logger;

const gcloudLogger =
  (category: string): LoggerBuilder =>
  (label: string) => ({
    debug: (message: unknown, ...args: unknown[]) =>
      formatGCloudMessage(category, "DEBUG", label, message, ...args),
    info: (message: unknown, ...args: unknown[]) =>
      formatGCloudMessage(category, "INFO", label, message, ...args),
    warn: (message: unknown, ...args: unknown[]) =>
      formatGCloudMessage(category, "WARNING", label, message, ...args),
    error: (message: unknown, ...args: unknown[]) =>
      formatGCloudMessage(category, "ERROR", label, message, ...args),
  });

const localLogger =
  (category: string): LoggerBuilder =>
  (label: string) => ({
    debug: (message: unknown, ...args: unknown[]) =>
      getLogger(category).debug(label, message, ...args),
    info: (message: unknown, ...args: unknown[]) =>
      getLogger(category).info(label, message, ...args),
    warn: (message: unknown, ...args: unknown[]) =>
      getLogger(category).warn(label, message, ...args),
    error: (message: unknown, ...args: unknown[]) =>
      getLogger(category).error(label, message, ...args),
  });

configure(log4jsConfig);

const logger = (category: string) =>
  env.NODE_ENV === "production"
    ? gcloudLogger(category)
    : localLogger(category);

export const infraLogger = logger("INFRA");
export const accessLogger = logger("ACCESS");
export const serviceLogger = logger("SERVICE");
