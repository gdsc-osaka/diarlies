/** Environmental variables. THIS FILE WILL BE OVERRIDE in production. **/
const env = {
  NODE_ENV: process.env.NODE_ENV,
  PORT: Number(process.env.PORT ?? "8080"),
  DATABASE_URL: process.env.DATABASE_URL,
  FIRE_SA: process.env.FIRE_SA!,
  STORAGE_CREDENTIALS: process.env.STORAGE_CREDENTIALS!,
  GEMINI_API_KEY: process.env.GEMINI_API_KEY!,
  GOOGLE_MAPS_API_KEY: process.env.GOOGLE_MAPS_API_KEY!,
  DISCORD_WEBHOOK_URL: process.env.DISCORD_WEBHOOK_URL!,
} as const;

export default env;
