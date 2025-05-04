import { drizzle, PostgresJsQueryResultHKT } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import schema from "./schema";
import env from "../env";
import type { PgTransaction } from "drizzle-orm/pg-core/session";
import { ExtractTablesWithRelations } from "drizzle-orm";

function getDBUrl(): string {
  if (env.NODE_ENV === "production") {
    return env.DATABASE_URL ?? "";
  }
  return "postgres://user:password@localhost:5432/db";
}

const client = postgres(getDBUrl(), { prepare: false });
const db = drizzle(client, { schema });

type TransactionClient = PgTransaction<
  PostgresJsQueryResultHKT,
  typeof schema,
  ExtractTablesWithRelations<typeof schema>
>;

export type DB = typeof db | TransactionClient;

export default db;
