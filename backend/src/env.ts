/** Environmental variables. THIS FILE WILL BE OVERRIDE in production. **/
const env = {
  NODE_ENV: process.env.NODE_ENV,
  DATABASE_URL: process.env.DATABASE_URL,
  FIRE_SA: process.env.FIRE_SA,
} as const;

export default env;
