-- List the titles of episodes from season 6 
-- (2008) that were released early, in 2007. 

-- Uses cyberchase.db

SELECT "title" FROM "episodes"
WHERE "air_date" BETWEEN date('2007-01-01') AND date('2007-12-31');
