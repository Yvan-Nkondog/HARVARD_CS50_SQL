-- Hits are great, but so are RBIs! In 12.sql, write a SQL query 
-- to find the players among the 10 least expensive players 
-- per hit and among the 10 least expensive players per RBI in 2001.

-- Your query should return a table with two columns, one for 
-- the players’ first names and one of their last names.
-- You can calculate a player’s salary per RBI by dividing 
-- their 2001 salary by their number of RBIs in 2001.
-- You may assume, for simplicity, that a player will only 
-- have one salary and one performance in 2001.
-- Order your results by player ID, least to greatest 
-- (or alphabetically by last name, as both are the same 
-- in this case!).
-- Keep in mind the lessons you’ve learned in 10.sql and 11.sql!

-- Uses moneyball.db

-- First query to select rows according to increasing "dollars per hit".
SELECT "first_name", "last_name"
FROM (
    SELECT
    "first_name",
    "last_name",
    CASE
        WHEN "H" != 0 THEN ROUND ("salary" * 1.0 / "H", 2)
        ELSE NULL
    END AS "dollars per hit" 
    FROM "players"
    JOIN "performances" ON "players"."id" = "performances"."player_id"
    JOIN "salaries" ON "salaries"."player_id" = "performances"."player_id"
    AND "salaries"."year" = "performances"."year"
    WHERE "H" != 0 
    AND "performances"."year" = 2001
    ORDER BY "dollars per hit" ASC
    LIMIT 10
)

-- Intersection point between the first and second query.
INTERSECT 

-- Second query to select rows according to increasing "dollars per RBI".
SELECT "first_name", "last_name"
FROM (
    SELECT
   "first_name",
   "last_name",
    CASE
        WHEN "RBI" != 0 THEN ROUND ("salary" * 1.0 / "RBI", 2)
        ELSE NULL
    END AS "dollars per RBI" 
    FROM "players"
    JOIN "performances" ON "players"."id" = "performances"."player_id"
    JOIN "salaries" ON "salaries"."player_id" = "performances"."player_id"
    AND "salaries"."year" = "performances"."year"
    WHERE "RBI" != 0 
    AND "performances"."year" = 2001
    ORDER BY "dollars per RBI" ASC
    LIMIT 10
)

-- After intersection of fist and second queries, 
-- order the result according to last_name.
ORDER BY "last_name" ASC
