DROP VIEW IF EXISTS "june_vacancies";

CREATE VIEW "june_vacancies" AS
SELECT
    "listings"."id",
    "property_type",
    "host_name",
    COUNT("availabilities"."date") AS "days_vacant"
FROM "listings"
LEFT JOIN "availabilities"
ON "availabilities"."listing_id" = "listings"."id"
AND "date" BETWEEN date('2023-06-01') AND date('2023-06-30')
AND "available" = 'TRUE'
GROUP BY "listings"."id";
