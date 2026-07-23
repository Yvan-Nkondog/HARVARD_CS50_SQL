-- Write SQL query to answer a question of your choice. 
-- This query should:
--      Make use of AS to rename a column
--      Involve at least condition, using WHERE
--      Sort by at least one column using ORDER BY

-- Uses players.db

-- Write a SQL query to find the players who 
-- played their final game in the MLB in 2020. 
-- Sort the results by age, from oldest to youngest,
-- then alphabetically by first name, then by last name.
-- Display the columns as follows : 
--      "birth_day" -> "Birth Day", etc.
--      (Remove the underscore and ensure each column
--      term starts with a capital letter).

SELECT 
    "first_name" AS "First Name", 
    "last_name" AS "Last Name",
    "birth_year" AS "Birth Year", 
    "birth_month" AS "Birth Month", 
    "birth_day" AS "Birth Day", 
    "final_game" AS "Final Game"
FROM "players"
WHERE "final_game" BETWEEN date('2020-01-01') AND date('2020-12-31')
ORDER BY "birth_year" ASC, "birth_month" ASC, "birth_day" ASC, 
"first_name" ASC, "last_name" ASC;
