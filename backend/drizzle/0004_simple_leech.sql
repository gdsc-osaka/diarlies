ALTER TABLE "diaries" ADD COLUMN "thumbnail_path" varchar(64);

UPDATE diaries SET thumbnail_path = 'sample' WHERE thumbnail_path IS NULL;

ALTEr TABLE "diaries" ALTER COLUMN "thumbnail_path" SET NOT NULL;