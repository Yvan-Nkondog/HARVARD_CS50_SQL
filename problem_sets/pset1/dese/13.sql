-- In 13.sql, write a SQL query to answer a 
-- question you have about the data! The query should:

-- Involve at least one JOIN or subquery

-- Uses dese.db

-- A parent asks you for advice on finding the best charter 
-- school districts in Massachusetts. In 13.sql, write a SQL 
-- query to find public school districts with above-average 
-- per-pupil expenditures and an above-average percentage of 
-- teachers rated “exemplary”. Your query should return the 
-- districts’ names, district type, per-pupil expenditures 
-- and percentage of teachers rated exemplary. Sort the results 
-- first by the per-pupil expenditure (high to low), 
-- then by the percentage of teachers rated exemplary 
-- (high to low).

SELECT "name", "type", "per_pupil_expenditure", "exemplary"
FROM (
    SELECT *
    FROM "districts"
    JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
    JOIN "expenditures" ON "expenditures"."district_id" = "districts"."id"
)
WHERE "type" = 'Charter District'
AND "per_pupil_expenditure" > (
    SELECT AVG("per_pupil_expenditure")
    FROM "expenditures"
)
AND "exemplary" > (
    SELECT AVG("exemplary")
    FROM "staff_evaluations"
)
ORDER BY "per_pupil_expenditure" DESC, "exemplary" DESC;
