import { getFirebaseToken } from "@hono/firebase-auth";

export type AuthUser = ReturnType<typeof getFirebaseToken>;
