-- Write a SQL query to find the titles of episodes that have aired
-- during the holiday season, usually in December in the United States.
--      1. Your query should output a table with a single column for 
--      the title of each episode.
--      2. Try to find a better solution than LIKE if you can!

-- Uses cyberchase.db

SELECT "title"
FROM "episodes"
WHERE strftime('%m', "air_date") = '12';
