-- List the titles of episodes from season 5, in reverse alphabetical order.

-- Uses cyberchase.db

SELECT "title" FROM "episodes"
WHERE "season" = 5
ORDER BY "title" DESC;
