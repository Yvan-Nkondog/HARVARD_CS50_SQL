-- Demonstrates limiting results with LIMIT
-- Uses longlist.db

-- Limit results to first 3
SELECT "title", "author" FROM "longlist" LIMIT 3;

-- Limit results to first 10
SELECT "title", "author" FROM "longlist" LIMIT 10;