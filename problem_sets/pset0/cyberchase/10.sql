-- Write a SQL query to list the ids, titles, and production codes 
-- of all episodes. Order the results by production code, from earliest 
-- to latest.

-- Uses cyberchase.db

SELECT "id", "title", "production_code" FROM "episodes"
ORDER BY "production_code" ASC;  -- Possible to ignore the default keyword "ASC".
