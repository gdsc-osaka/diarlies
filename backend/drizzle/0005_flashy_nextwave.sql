ALTER TABLE "users" ADD COLUMN "name" varchar(50);--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "handle" varchar(50);

UPDATE users SET name = 'sample' WHERE name IS NULL;
UPDATE users SET handle = 'sample' WHERE handle IS NULL;

ALTER TABLE "users" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "users" ALTER COLUMN "handle" SET NOT NULL;