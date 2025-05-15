CREATE TABLE "users" (
	"id" varchar(25) PRIMARY KEY NOT NULL,
	"uid" varchar(28) NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "users_uid_unique" UNIQUE("uid")
);
--> statement-breakpoint
CREATE INDEX "users_uid_idx" ON "users" USING btree ("uid");