-- Choose a location of your own and write a SQL 
-- query to find the normal temperature at 0 meters, 
-- 100 meters, and 200 meters. You might find Google 
-- Earth :
-- https://earth.google.com/
-- helpful if you’d like to find some coordinates to use!

-- Uses normals.db

-- The location corresponding to the "id" at the middle of
-- the normals.db has been selected. Six columns have
-- been displayed.

SELECT "id", "latitude", "longitude", "0m", "100m", "200m"
FROM "normals"
WHERE "id" = (
    SELECT COUNT(*) / 2 
    FROM "normals"
    );

