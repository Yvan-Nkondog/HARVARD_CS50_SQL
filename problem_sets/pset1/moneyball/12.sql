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

SELECT * FROM "performances" LIMIT 1;
SELECT * FROM "players" LIMIT 1;
SELECT * FROM "salaries" LIMIT 1;
SELECT * FROM "teams" LIMIT 1;

SELECT
   "first_name",
   "last_name",
   CASE
      WHEN "H" != 0 THEN ROUND ("salary" * 1.0 / "H", 2)
      ELSE NULL
    END AS "dollars per hit" 
    CASE
      WHEN "RBI" != 0 THEN ROUND ("salary" * 1.0 / "RBI", 2)
      ELSE NULL
    END AS "dollars per RBI" 
FROM "players"
JOIN "performances" ON "players"."id" = "performances"."player_id"
JOIN "salaries" ON "salaries"."player_id" = "performances"."player_id"
AND "salaries"."year" = "performances"."year"
WHERE "H" != 0 
WHERE "RBI" != 0 
AND "salaries"."year" = 2001
ORDER BY "dollars per hit" ASC, "first_name" ASC, "last_name" ASC
LIMIT 10;
