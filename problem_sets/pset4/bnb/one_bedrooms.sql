DROP VIEW IF EXISTS "one_bedrooms";

CREATE VIEW "one_bedrooms" AS
SELECT
    "id",
    "property_type",
    "host_name",
    "accommodates"
FROM "listings"
WHERE "bedrooms" = 1;
