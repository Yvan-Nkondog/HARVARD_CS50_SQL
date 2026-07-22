-- Write a SQL query to list the English titles of the 5 
-- brightest prints by Hiroshige, from most to least bright. 
-- Compare them to this list on Wikipedia :
-- https://en.wikipedia.org/wiki/Thirty-six_Views_of_Mount_Fuji_(Hiroshige) 
-- to see if your results match the print’s aesthetics.

-- Uses views.db

SELECT "english_title"
FROM "views"
WHERE "artist" = 'Hiroshige'
ORDER BY "brightness" DESC
LIMIT 5;
