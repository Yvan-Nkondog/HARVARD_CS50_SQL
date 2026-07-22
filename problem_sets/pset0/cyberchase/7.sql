-- Write a SQL query to list the titles and 
-- topics of all episodes teaching fractions.

-- Uses cyberchase.db

SELECT "title", "topic" FROM "episodes"
WHERE "topic" LIKE '%fraction%';
