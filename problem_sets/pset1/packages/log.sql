-- PART 1
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


-- Obtain the ID and type of sender's address.
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

-- Conclusion :
-- The package has been picked from the correct address and dropped at the correct
-- destination.




-- PART 2
-- *** The Devious Delivery ***

-- One important information mentionned is that the
-- "from_address_id" IS NULL. Hence, I have started by
-- filtering the packages to keep only those having
-- "from_address_id" = NULL.
SELECT *
FROM "packages"
WHERE "from_address_id" IS NULL;
-- Output (only one package):
-- ╭──────┬───────────────┬─────────────────┬───────────────╮
-- │  id  │   contents    │ from_address_id │ to_address_id │
-- ╞══════╪═══════════════╪═════════════════╪═══════════════╡
-- │ 5098 │ Duck debugger │ NULL            │            50 │
-- ╰──────┴───────────────┴─────────────────┴───────────────╯


-- From scans, track the package using the package ID.
SELECT *
FROM "scans"
WHERE "package_id" = 5098;
-- Output :
-- ╭───────┬───────────┬────────────┬────────────┬────────┬────────────────────────────╮
-- │  id   │ driver_id │ package_id │ address_id │ action │         timestamp          │
-- ╞═══════╪═══════════╪════════════╪════════════╪════════╪════════════════════════════╡
-- │ 30123 │        10 │       5098 │         50 │ Pick   │ 2023-10-24 08:40:16.246648 │
-- │ 30140 │        10 │       5098 │        348 │ Drop   │ 2023-10-24 10:08:55.610754 │
-- ╰───────┴───────────┴────────────┴────────────┴────────┴────────────────────────────╯


SELECT *
FROM "addresses"
WHERE "id" = 50 OR "id" = 348;
-- Output :
-- ╭─────┬───────────────────┬────────────────╮
-- │ id  │      address      │      type      │
-- ╞═════╪═══════════════════╪════════════════╡
-- │  50 │ 123 Sesame Street │ Residential    │
-- │ 348 │ 7 Humboldt Place  │ Police Station │
-- ╰─────┴───────────────────┴────────────────╯

-- According to the time stamp, from the "scans" table, the package has
-- been dropped at address with id 348. Using the "addresses" table,
-- I have confirmed that the address "type" is a "Police Station", located
-- at (address) 7 Humboldt Place. 
-- According to the "scans" table, the package has left from address_id
-- 50, which corresponds to 123 Sesame Street, a "Residential" address.




-- PART 3
-- *** The Forgotten Gift ***

-- Select the sending and the destination addresses.
-- "ORDER BY" add in order to keep the sending address
-- before the destination address.
SELECT *
FROM "addresses"
WHERE "address" = '109 Tileston Street'
OR "address" = '728 Maple Place'
ORDER BY "address" ASC;
-- Output :
-- ╭──────┬─────────────────────┬─────────────╮
-- │  id  │       address       │    type     │
-- ╞══════╪═════════════════════╪═════════════╡
-- │ 9873 │ 109 Tileston Street │ Residential │
-- │ 4983 │ 728 Maple Place     │ Residential │
-- ╰──────┴─────────────────────┴─────────────╯


-- Identify the package (and its content) using the 
-- sender's address and destination address.
SELECT *
FROM "packages"
WHERE "from_address_id" = 9873
AND "to_address_id" = 4983;
-- Output :
-- ╭──────┬──────────┬─────────────────┬───────────────╮
-- │  id  │ contents │ from_address_id │ to_address_id │
-- ╞══════╪══════════╪═════════════════╪═══════════════╡
-- │ 9523 │ Flowers  │            9873 │          4983 │
-- ╰──────┴──────────┴─────────────────┴───────────────╯

-- Content : Flowers, package id : 9523.


-- Select, from "scans", the package corresponding to the
-- package id.
SELECT *
FROM "scans"
WHERE "package_id" = 9523;
-- Output :
-- ╭───────┬───────────┬────────────┬────────────┬────────┬────────────────────────────╮
-- │  id   │ driver_id │ package_id │ address_id │ action │         timestamp          │
-- ╞═══════╪═══════════╪════════════╪════════════╪════════╪════════════════════════════╡
-- │ 10432 │        11 │       9523 │       9873 │ Pick   │ 2023-08-16 21:41:43.219831 │
-- │ 10500 │        11 │       9523 │       7432 │ Drop   │ 2023-08-17 03:31:36.856889 │
-- │ 12432 │        17 │       9523 │       7432 │ Pick   │ 2023-08-23 19:41:47.913410 │
-- ╰───────┴───────────┴────────────┴────────────┴────────┴────────────────────────────╯

-- The package has not been dropped at the correct address (4983). The package has been
-- picked from the wrong address but has not been dropped at another address.


-- Get information about the driver.
SELECT *
FROM "drivers"
WHERE "id" = 11;
-- Output : 
-- ╭────┬────────╮
-- │ id │  name  │
-- ╞════╪════════╡
-- │ 11 │ Maegan │
-- ╰────┴────────╯


-- Get information about currect address of package.
SELECT *
FROM "addresses"
WHERE "id" = 7432;
-- Output :
-- ╭──────┬────────────────────────┬───────────╮
-- │  id  │        address         │   type    │
-- ╞══════╪════════════════════════╪═══════════╡
-- │ 7432 │ 950 Brannon Harris Way │ Warehouse │
-- ╰──────┴────────────────────────┴───────────╯

-- Conclusion : 
-- The package has been dropped at a "Warehouse",
-- at address "950 Brannon Harris Way". When
-- writing this query, the package is not more
-- are that address, has been picked from the "Warehouse",
-- but has not reached another destination (sender) or
-- grand-daughter.
