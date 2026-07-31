-- *** The Lost Letter ***

-- It has clearly been mentionned that the destination
-- address is likely to contain a problem.
-- Hence, I have searched the address using
-- SQL "LIKE" command.
-- The closest name obtained is '2 Finnigan Street'.
-- It is a residential address of ID 854.
-- Note that the spelling is different from the
-- original name :
-- '2 Finnegan Street, uptown'.
SELECT *
FROM "addresses"
WHERE "address" LIKE '%2 F%'
ORDER BY "address" ASC;
-- Output :
-- ╭──────┬─────────────────────────────────┬─────────────╮
-- │  id  │             address             │    type     │
-- ╞══════╪═════════════════════════════════╪═════════════╡
-- │   45 │ 12 Foster Street                │ Business    │
-- │  ... │                                 │      ...    │
-- │  854 │ 2 Finnigan Street               │ Residential │
-- │  ... │                                 │      ...    │


-- Obtain the ID and type of departure address.
-- ID = 432, type = Residential.
SELECT *
FROM "addresses"
WHERE "address" = '900 Somerville Avenue';
-- Output :
-- ╭─────┬───────────────────────┬─────────────╮
-- │ id  │        address        │    type     │
-- ╞═════╪═══════════════════════╪═════════════╡
-- │ 432 │ 900 Somerville Avenue │ Residential │
-- ╰─────┴───────────────────────┴─────────────╯


-- Check if a package has left from sender's address
-- to the appropriate destination, the content of the package,
-- and obtain the package ID. 
SELECT *
FROM "packages"
WHERE "from_address_id" = 432
AND "to_address_id" = 854;
--  Output : 
-- ╭─────┬───────────────────────┬─────────────────┬───────────────╮
-- │ id  │       contents        │ from_address_id │ to_address_id │
-- ╞═════╪═══════════════════════╪═════════════════╪═══════════════╡
-- │ 384 │ Congratulatory letter │             432 │           854 │
-- ╰─────┴───────────────────────┴─────────────────┴───────────────╯


-- Check the scans to identify the real final destination of the
-- package.
SELECT * 
FROM "scans"
WHERE "package_id" = 384;
-- Output :
-- ╭────┬───────────┬────────────┬────────────┬────────┬────────────────────────────╮
-- │ id │ driver_id │ package_id │ address_id │ action │         timestamp          │
-- ╞════╪═══════════╪════════════╪════════════╪════════╪════════════════════════════╡
-- │ 54 │         1 │        384 │        432 │ Pick   │ 2023-07-11 19:33:55.241794 │
-- │ 94 │         1 │        384 │        854 │ Drop   │ 2023-07-11 23:07:04.432178 │
-- ╰────┴───────────┴────────────┴────────────┴────────┴────────────────────────────╯

-- The package has been picked from the correct address and dropped at the correct
-- destination.

-- *** The Devious Delivery ***

-- *** The Forgotten Gift ***

