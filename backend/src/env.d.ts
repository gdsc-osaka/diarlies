declare module "process" {
  global {
    namespace NodeJS {
      interface ProcessEnv {
        NODE_ENV?: "development" | "production";
        DATABASE_URL?: string;
        FIRE_SA: string;
      }
    }
  }
}
