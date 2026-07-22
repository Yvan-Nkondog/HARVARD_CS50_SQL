-- Write a query that counts the number of episodes released 
-- in Cyberchase’s first 6 years, from 2002 to 2007, inclusive.

-- Uses cyberchase.db

SELECT COUNT("id") FROM "episodes"
WHERE "air_date" BETWEEN date('2002-01-01') AND date('2007-12-31')
