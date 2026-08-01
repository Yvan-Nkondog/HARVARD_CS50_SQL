
-- Delete the table "meteorites_temp" if it exists.
DROP TABLE IF EXISTS "meteorites_temp";

-- Generate the schema for the table "meteorites_temp".
-- "IF NOT EXISTS" not added because the table has been
-- deleted in the previous line of code.
CREATE TABLE "meteorites_temp" (
    "name" TEXT NOT NULL,
    "id" INTEGER UNIQUE,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

-- Import the content of the meteorites.csv to a temp 
-- table (meteorites_temp).

.import --csv --skip 1 meteorites.csv meteorites_temp


-- Start the data cleaning process :

-- 1. Any empty values in meteorites.csv are represented 
-- by NULL in the meteorites table. Keep in mind that the 
-- mass, year, lat, and long columns have empty values in the CSV.
UPDATE "meteorites_temp"
SET 
    "mass" = CASE WHEN "mass" = '' THEN NULL ELSE "mass" END,
    "year" = CASE WHEN "year" = '' THEN NULL ELSE "year" END,
    "lat" = CASE WHEN "lat" = '' THEN NULL ELSE "lat" END,
    "long" = CASE WHEN "long" = '' THEN NULL ELSE "long" END;


-- 2. All columns with decimal values (e.g., 70.4777) should be 
-- rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
-- Keep in mind that the mass, lat, and long columns have decimal values.
UPDATE "meteorites_temp"
SET
    "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);


-- 3. All meteorites with the nametype "Relict" are not 
-- included in the meteorites table.
DELETE
FROM "meteorites_temp"
WHERE "nametype" = 'Relict';


-- 4. The meteorites are sorted by year, oldest to newest, 
-- and then—if any two meteorites landed in the same year—by 
-- name, in alphabetical order.

-- 5. You’ve updated the IDs of the meteorites from 
-- meteorites.csv, according to the order specified in #4.
-- The id of the meteorites should start at 1, beginning with 
-- the meteorite that landed in the oldest year and is the 
-- first in alphabetical order for that year.

-- Delete the table "meteorites_temp" if it exists.
DROP TABLE IF EXISTS "meteorites";

-- Generate the schema for the table "meteorites".
-- Do not include the column "nametype" in the schema.
-- "IF NOT EXISTS" not added because the table has been
-- deleted in the previous line of code.
CREATE TABLE "meteorites" (
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


-- Insert elements from the temporary table (meteorites_temp)
-- to the new table (meteorites). Autoincrement the primary key (id).
INSERT INTO "meteorites"("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year" ASC, "name" ASC;

-- Delete the temporary table meteorites_temp.
DROP TABLE IF EXISTS "meteorites_temp";


-- Display the cleaned data
SELECT *
FROM "meteorites"
LIMIT 1000;

-- Note : The question has not specified whether the "NULL"
-- values for years should appear after or before the
-- years containing normal values. The default behaviour
-- of the sqlite (NULL before values arranged in 
-- ascending order) has been implemented.
