-- Write a SQL query to answer a question of your choice about 
-- the prints. The query should:
--      1. Make use of AS to rename a column
--      2. Involve at least one condition, using WHERE
--      3. Sort by at least one column, using ORDER BY

-- Selected query
-- Arrange all the english titles containing the keywords 
-- 'eastern capital' and 'edo' name in decreasing 
-- order of brighness. 

-- Uses views.db

SELECT "english_title"
AS "English Title"
FROM "views"
WHERE ("english_title" 
LIKE '%eastern capital%'
OR "english_title" LIKE '%edo%')
ORDER BY "brightness" DESC;
