-- Two parents want to send their child to a district with many 
-- other students. In 8.sql, write a SQL query to display the 
-- names of all school districts and the number of pupils 
-- enrolled in each.

-- Uses dese.db

SELECT "name", "pupils"
FROM (
    SELECT *
    FROM "districts"
    JOIN "expenditures" ON "expenditures"."district_id" = "districts"."id"
);
