-- Write a SQL query to list the English titles of the 5 
-- prints with the least contrast by Hokusai, from least to 
-- highest contrast. Compare them to this list on Wikipedia :
-- https://en.wikipedia.org/wiki/Thirty-six_Views_of_Mount_Fuji
-- to see if your results match the print’s aesthetics.

-- Uses views.db

SELECT "english_title"
FROM "views"
WHERE "artist" = 'Hokusai'
ORDER BY "contrast" ASC
LIMIT 5;
