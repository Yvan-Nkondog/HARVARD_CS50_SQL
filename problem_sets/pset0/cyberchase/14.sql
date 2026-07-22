-- The query in this file has been added to show the
-- titles that appear more than one, based on the query
-- presented in "12.sql" file.

-- Uses cyberchase.db

SELECT "title", COUNT(*) FROM "episodes"
GROUP BY "title"
HAVING COUNT(*) > 1;
