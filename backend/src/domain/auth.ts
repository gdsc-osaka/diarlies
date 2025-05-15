import { getFirebaseToken } from "@hono/firebase-auth";

export type AuthUser = NonNullable<ReturnType<typeof getFirebaseToken>>;
