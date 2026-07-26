-- Which teams might be the biggest competition for the A’s 
-- this year? In 6.sql, write a SQL query to return 
-- the top 5 teams, sorted by the total number of hits by 
-- players in 2001.

--     Call the column representing total hits by players in 2001 “total hits”.
--     Sort by total hits, highest to lowest.
--     Your query should return two columns, one for the teams’ 
--     names and one for their total hits in 2001.

-- Uses moneyball.db

SELECT 
    "name",
    SUM("H") AS "total hits"
FROM (
    SELECT *
    FROM "performances"
    JOIN "teams" ON "teams"."id" = "performances"."team_id"
)
WHERE "year" = 2001
GROUP BY "team_id"
ORDER BY "total hits" DESC
LIMIT 5;
