-- In by_district.sql, write a SQL statement to create 
-- a view named by_district. This view should contain 
-- the sums for each numeric column in census, grouped 
-- by district. Ensure the view contains each of the following columns:

--      district, which is the name of the district.
--      families, which is the total number of families in the district.
--      households, which is the total number of households in the district.
--      population, which is the total population of the district.
--      male, which is the total number of people identifying as male in the district.
--      female, which is the total number of people identifying as female in the district.

-- Delete any view of name "total".
DROP VIEW IF EXISTS "by_district";

-- Create the required view.
CREATE VIEW "by_district" AS
SELECT
    "district",
    SUM("families") AS "families",
    SUM("households") AS "households",
    SUM("population") AS "population",
    SUM("male") AS "male",
    SUM("female") AS "female"
FROM "census"
GROUP BY "district";

-- Test :
-- SELECT * FROM "by_district";
-- Mustang district : 3 751 families
