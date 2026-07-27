-- It’s a bit of a slow day in the office. Though Satchel no longer 
-- plays, in 5.sql, write a SQL query to find all teams 
-- that Satchel Paige played for.

--     Your query should return a table with a single column, 
--     one for the name of the teams.

-- Uses moneyball.db

SELECT DISTINCT "name"
FROM (
    SELECT
    "name",
    "teams"."id", 
    "performances"."team_id",
    "salaries"."team_id",
    "players"."id",
    "performances"."player_id",
    "salaries"."player_id"
    -- Start by joining teams on without reducing the number of rows from
    -- the column "teams"."id" and corresponding columns in other tables
    -- (use LEFT JOIN)
    FROM "teams" 
    LEFT JOIN "performances" ON "performances"."team_id" = "teams"."id"
    LEFT JOIN "salaries" ON "salaries"."team_id" = "teams"."id"
    -- Filter all the columns with "team id" = NULL from the joint table, then
    -- merge the player table to the joint table.
    JOIN "players" 
        ON ("players"."id" = "performances"."player_id" AND "performances"."team_id" IS NOT NULL)
        OR ("players"."id" = "salaries"."player_id" AND "salaries"."team_id" IS NOT NULL)
    
    -- Filter the joint table by player's "id" using a sub-query.
    WHERE "players"."id" = (
        SELECT "id"
        FROM "players"
        WHERE "first_name" = 'Satchel' AND "last_name" = 'Paige'
    )
);
