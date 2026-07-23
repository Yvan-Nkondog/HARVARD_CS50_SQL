-- Write a SQL query to find the ids of rows 
-- for which a value in the column debut is missing.

-- Uses players.db

SELECT "id"
FROM "players"
WHERE "debut" IS NULL
