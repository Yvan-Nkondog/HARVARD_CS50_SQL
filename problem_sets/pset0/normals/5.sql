-- Write a SQL query to find the highest normal ocean 
-- surface temperature.

-- Uses normals.db

SELECT MAX("0m")
FROM "normals";
