declare module "process" {
  global {
    namespace NodeJS {
      interface ProcessEnv {
        NODE_ENV?: "development" | "production";
        DATABASE_URL?: string;
        FIRE_SA: string;

        GEMINI_API_KEY: string;
        GOOGLE_MAPS_API_KEY: string;
      }
    }
  }
}
