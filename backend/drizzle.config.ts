import { defineConfig } from "drizzle-kit";

export default defineConfig({
    dialect: "postgresql",
    schema: "./src/drizzle/schema.ts",
    out: "./drizzle",
    dbCredentials: {
        host: "localhost",
        port: 5432,
        user: "user",
        password: "password",
        database: "db",
        ssl: false
    }
});
