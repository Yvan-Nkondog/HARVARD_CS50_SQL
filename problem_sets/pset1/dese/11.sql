-- Is there a relationship between school expenditures 
-- and graduation rates? In 11.sql, write a SQL query 
-- to display the names of schools, their per-pupil expenditure, 
-- and their graduation rate. Sort the schools from greatest 
-- per-pupil expenditure to least. If two schools have the same
-- per-pupil expenditure, sort by school name.

-- You should assume a school spends the same amount 
-- per-pupil their district as a whole spends.

-- Uses dese.db

SELECT "name", "per_pupil_expenditure", "graduated"
FROM (
    SELECT *
    FROM (
        SELECT *
        FROM "schools"
        JOIN "expenditures" ON "expenditures"."district_id" = "schools"."district_id"
        JOIN "graduation_rates" ON "graduation_rates"."school_id" = "schools"."id"
    )
)
ORDER BY "per_pupil_expenditure" DESC, "name";


