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
  return "postgres://user:password@localhost:6543/db";
}

const db = () => drizzle(postgres(getDBUrl()), { schema });

type TransactionClient = PgTransaction<
  PostgresJsQueryResultHKT,
  typeof schema,
  ExtractTablesWithRelations<typeof schema>
>;

export type DB = ReturnType<typeof db>;
export type DBorTx = DB | TransactionClient;

export default db;
