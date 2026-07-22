-- Find the title of the holiday episode 
-- that aired on December 31st, 2004.

-- Uses cyberchase.db

SELECT "title" FROM "episodes"
WHERE "air_date" = date('2004-12-31');
