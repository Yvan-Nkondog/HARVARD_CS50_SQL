-- Write a SQL query to find the players who 
-- played their final game in the MLB in 2022. 
-- Sort the results alphabetically by first name, 
-- then by last name.

-- Uses players.db

SELECT "first_name", "last_name"
FROM "players"
WHERE "final_game" BETWEEN date('2022-01-01') AND date('2022-12-31')
ORDER BY "first_name" ASC, "last_name" ASC;
