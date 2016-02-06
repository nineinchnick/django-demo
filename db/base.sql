BEGIN;
--
-- Create model Entry
--
CREATE TABLE "whoami_entry" ("id" serial NOT NULL PRIMARY KEY, "contents" text NOT NULL, "created_on" timestamp with time zone NOT NULL);

COMMIT;
