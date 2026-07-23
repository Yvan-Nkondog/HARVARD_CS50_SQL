-- Write a SQL query to find, for each year, the first day 
-- of the year that PBS released a Cyberchase episode.
--      Your query should output a table with two columns, one 
--      for the year and one for the earliest month and 
--      day an episode was released that year.

-- Uses cyberchase.db

SELECT DISTINCT
    strftime('%Y', "air_date") AS "Year", 
    strftime('%m-%d', "air_date") AS "Month-Day"
FROM "episodes"
WHERE "air_date" IN (
    -- Internal SQL query to obtain the earliest date
    -- value for each year.
    SELECT MIN("air_date")
    FROM "episodes"
    GROUP BY strftime('%Y', air_date)
)
ORDER BY strftime('%Y', "air_date") DESC;  
