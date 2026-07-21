-- Demonstrates empty values with NULL
-- Uses longlist.db

-- Books without a translator
SELECT "title", "translator" FROM "longlist" WHERE "translator" IS NULL;

-- Books with a translator
SELECT "title", "translator" FROM "longlist" WHERE "translator" IS NOT NULL;