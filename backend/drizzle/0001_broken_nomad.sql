CREATE TYPE "public"."diary_generation_enum" AS ENUM('PROCESSING', 'COMPLETED', 'FAILED');--> statement-breakpoint
CREATE TABLE "diaries" (
	"id" varchar(25) PRIMARY KEY NOT NULL,
	"user_id" varchar(25),
	"content" varchar(1000) NOT NULL,
	"diary_date" date NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "diary_generation_jobs" (
	"id" varchar(25) PRIMARY KEY NOT NULL,
	"diary_id" varchar(25),
	"status" "diary_generation_enum" NOT NULL,
	"error_message" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL,
	"completed_at" timestamp
);
--> statement-breakpoint
ALTER TABLE "diaries" ADD CONSTRAINT "diaries_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "diaries_user_id_idx" ON "diaries" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "diaries_diary_date_idx" ON "diaries" USING btree ("diary_date");