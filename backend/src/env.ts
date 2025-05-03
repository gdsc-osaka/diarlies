/** Environmental variables. THIS FILE WILL BE OVERRIDE in production. **/
export const env = {
  NODE_ENV: process.env.NODE_ENV,
} as const;

export type EnvKey = keyof typeof env;
