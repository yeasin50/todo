BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "todo" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo" (
    "id" serial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "isChecked" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR todo
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todo', '20240503182420627', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240503182420627', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
