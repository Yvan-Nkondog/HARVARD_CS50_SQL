-- Write a SQL query to find the side 
-- (e.g., right or left) Babe Ruth hit.

-- Uses players.db

SELECT "bats"
FROM "players"
WHERE "first_name" = 'Babe' AND "last_name" = 'Ruth';
