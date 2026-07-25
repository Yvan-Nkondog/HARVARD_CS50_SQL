-- A parent asks you for advice on finding the best public 
-- school districts in Massachusetts. In 12.sql, write a SQL 
-- query to find public school districts with above-average 
-- per-pupil expenditures and an above-average percentage of 
-- teachers rated “exemplary”. Your query should return the 
-- districts’ names, along with their per-pupil expenditures 
-- and percentage of teachers rated exemplary. Sort the results 
-- first by the percentage of teachers rated exemplary (high to low), 
-- then by the per-pupil expenditure (high to low).

-- Uses dese.db

SELECT "name", "per_pupil_expenditure", "exemplary"
FROM (
    SELECT *
    FROM "districts"
    JOIN "expenditures" ON "expenditures"."district_id" = "districts"."id"
    JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
)
WHERE "per_pupil_expenditure" > (
    SELECT AVG("per_pupil_expenditure")
    FROM "expenditures"
)
AND "exemplary" > (
    SELECT AVG("exemplary")
    FROM "staff_evaluations"
)
AND "type" = 'Public School District'
ORDER BY "exemplary" DESC, "per_pupil_expenditure" DESC;
