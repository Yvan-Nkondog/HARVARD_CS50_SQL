-- You can optionally attempt the below queries, 
-- which may require some advanced knowledge!

-- Write a single SQL query to list the first and 
-- last names of all players of above average height, 
-- sorted tallest to shortest, then by first and last name.

-- Uses players.db

SELECT "first_name", "last_name"
FROM "players"
WHERE "height" > (
    SELECT AVG("height")
    FROM "players"
    )
ORDER BY "height" DESC, "first_name" ASC, "last_name" ASC;

-- Note : The following small test has been carried out.
--      Number of players above average height : 9589
--      Number of players below average height : 10449
--      Number of players of unknown height (NULL) : 731
--      Total number of players (SELECT COUNT (*) FROM "players") : 20769
--      9589 + 10449 + 731 = 20769
