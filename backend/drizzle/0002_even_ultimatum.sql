CREATE TYPE "public"."account_visibility" AS ENUM('private', 'public');--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "visibility" "account_visibility" DEFAULT 'private' NOT NULL;