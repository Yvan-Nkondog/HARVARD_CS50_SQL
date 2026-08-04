-- The app’s user engagement team needs to identify active 
-- users. Find all usernames of users who have logged in since 
-- 2024-01-01. Ensure your query uses the search_users_by_last_login index, 
-- which is defined as follows:

--      CREATE INDEX "search_users_by_last_login"
--      ON "users"("last_login_date");

-- Uses snap.db


-- Delete existing index.
DROP INDEX IF EXISTS "search_users_by_last_login";

-- Create the index mentioned in the question.
CREATE INDEX "search_users_by_last_login"
ON "users"("last_login_date");

-- Execute the query
SELECT "username" 
FROM "users"
WHERE "last_login_date" > date('2024-01-01');

-- Explain the query plan
EXPLAIN QUERY PLAN
SELECT "username" 
FROM "users"
WHERE "last_login_date" > date('2024-01-01');

