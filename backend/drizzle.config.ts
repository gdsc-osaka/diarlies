import { defineConfig } from "drizzle-kit";

export default defineConfig({
    dialect: "postgresql",
    schema: "./src/db/schema/*",
    out: "./drizzle",
    dbCredentials: {
        host: "localhost",
        port: 6543,
        user: "user",
        password: "password",
        database: "db",
        ssl: false
    }
});
