-- Another pair of parents want to send their child to a 
-- district with few other students. In 9.sql, write 
-- a SQL query to find the name (or names) of the school
-- district(s) with the single least number of pupils. 
-- Report only the name(s).

-- Uses dese.db

SELECT "name"
FROM (
    SELECT *
    FROM "districts"
    JOIN "expenditures" ON "expenditures"."district_id" = "districts"."id"
)
WHERE "pupils" = (
    SELECT MIN("pupils")
    FROM "expenditures"
);

