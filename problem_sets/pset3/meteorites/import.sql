
DROP TABLE IF EXISTS "meteorites_temp";

CREATE TABLE IF NOT EXISTS "meteorites_temp" (
    "name" TEXT NOT NULL,
    "id" INTEGER UNIQUE,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL
);

-- Import the content of the meteorites.csv to a temp 
-- table (meteorites_temp).

.import --csv --skip 1 meteorites.csv meteorites_temp

SELECT *
FROM "meteorites_temp"
LIMIT 500;


-- Replace all empty values by 'NULL' in the table.
UPDATE meteorites_temp
SET 
    "mass" = CASE WHEN "mass" = '' THEN NULL ELSE "mass" END,
    "year" = CASE WHEN "year" = '' THEN NULL ELSE "year" END,
    "lat" = CASE WHEN "lat" = '' THEN NULL ELSE "lat" END,
    "long" = CASE WHEN "long" = '' THEN NULL ELSE "long" END;


UPDATE "meteorites_temp"
SET
    "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);

SELECT *
FROM "meteorites_temp"
LIMIT 500;

SELECT COUNT(*)
FROM meteorites_temp;

DELETE
FROM meteorites_temp
WHERE "nametype" = 'Relict';

SELECT COUNT(*)
FROM meteorites_temp;




DROP TABLE IF EXISTS "meteorites";

CREATE TABLE IF NOT EXISTS "meteorites" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);


INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year" ASC, "name" ASC;


SELECT *
FROM "meteorites"
LIMIT 1000;

