DROP VIEW IF EXISTS "frequently_reviewed";

CREATE VIEW "frequently_reviewed" AS
SELECT
    "listings"."id",
    "property_type",
    "host_name",
    COUNT("listings"."id") AS "reviews"
FROM "listings"
JOIN "reviews"
ON "reviews"."listing_id" = "listings"."id"
GROUP BY  "listings"."id"
ORDER BY "reviews" DESC
LIMIT 100;
