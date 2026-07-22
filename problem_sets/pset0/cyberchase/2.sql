-- List the season number of, and title of, 
-- the first episode of every season.

-- Uses cyberchase.db

SELECT "season", "title" FROM "episodes"
WHERE "episode_in_season" = 1;
