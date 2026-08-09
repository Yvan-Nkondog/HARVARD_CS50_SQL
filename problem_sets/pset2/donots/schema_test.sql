
-- Delete all existing tables.
DROP TABLE IF EXISTS "ingredient_lists";
DROP TABLE IF EXISTS "order_items";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "ingredients";
DROP TABLE IF EXISTS "donots";
DROP TABLE IF EXISTS "customers";

-- Create tables according to the specifications.
CREATE TABLE "ingredients" (
    "id" INTEGER,
    "ingredient_name" TEXT NOT NULL,
    "price_per_unit" REAL NOT NULL CHECK ("price_per_unit" >=0),
    "unit" TEXT NOT NULL CHECK ("unit" IN ('pound', 'gram', 'kilogram')),
    PRIMARY KEY("id")
);

CREATE TABLE "donots" (
    "id" INTEGER,
    "donot_name" TEXT NOT NULL UNIQUE,
    "gluten_included" INTEGER NOT NULL CHECK ("gluten_included" IN (0, 1)),
    "price_per_donot" REAL NOT NULL CHECK ("price_per_donot" >= 0),
    PRIMARY KEY("id")
);

CREATE TABLE "ingredient_lists" (
    "id" INTEGER,
    "donot_id" INTEGER NOT NULL,
    "ingredient_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY ("donot_id") REFERENCES "donots"("id") ON DELETE CASCADE,
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE CASCADE
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "customer_id" INTEGER,
    "order_datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id") ON DELETE CASCADE
);

CREATE TABLE order_items (
    "id" INTEGER,
    "order_id" INTEGER NOT NULL,
    "donot_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL CHECK ("quantity" > 0),
    PRIMARY KEY("id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("id") ON DELETE CASCADE,
    FOREIGN KEY("donot_id") REFERENCES "donots"("id") ON DELETE CASCADE
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);


---------------------------------------------------------------------------------
-- Insert data and test the database.
---------------------------------------------------------------------------------


-- Part 1 : Insert into ingredients.
INSERT INTO "ingredients"("ingredient_name", "price_per_unit", "unit")
VALUES
('Cocoa', 5.00, 'pound'),
('Sugar', 2.00, 'pound'),
('Flour', 2.00, 'pound'),
('Buttermilk', 3.00, 'pound'),
('Sprinkles', 10.00, 'gram'),
('Yeast', 1.00, 'gram'),
('Oil', 12.00, 'kilogram'),
('Butter', 22.50, 'kilogram');

-- Display the list of ingredients.
SELECT * FROM "ingredients";


-- Insert into the table donots (gluten_included : 0 => gluten_free).
INSERT INTO "donots"("donot_name", "gluten_included", "price_per_donot")
VALUES
('Belgian Dark Chocolate', 0, 4.00),
('Back-To-Work Sprinkles', 1, 4.00);

-- Display the list of donot types.
SELECT * FROM "donots";


-- Insert into the table ingredient_list.
INSERT INTO "ingredient_lists"("donot_id", "ingredient_id")
VALUES
-- Ingredients for 'Belgian Dark Chocolate'.
(1, 1),
(1, 3),
(1, 4),
(1, 2),
-- Ingredients for 'Back-To-Work Sprinkles'.
(2, 3),
(2, 4),
(2, 2),
(2, 5);

-- Display the 3rd and 4th tests (from exercise link).
SELECT "donot_name", "gluten_included", "price_per_donot", "ingredient_name"
FROM "ingredient_lists"
JOIN "donots" ON "donots"."id" = "ingredient_lists"."donot_id"
JOIN "ingredients" ON "ingredients"."id" = "ingredient_lists"."ingredient_id";


-- Insert into the table customers.
INSERT INTO "customers"("first_name", "last_name")
VALUES
('John', 'Doe'),
('Jane', 'Smith');

-- Display the 'customers' table.
SELECT * FROM "customers";

-- Insert into the table orders.
INSERT INTO "orders"("customer_id", "order_datetime")
VALUES
(1, '2024-07-17 10:15:17'),
(2, '2026-01-14 19:14:11');

INSERT INTO "orders"("customer_id")
VALUES
(1),
(2);

-- Display the 'orders' table.
SELECT * FROM "orders";

-- Insert data into table "order_items".
INSERT INTO "order_items"("order_id", "donot_id", "quantity")
VALUES
-- Order 1 : Note : Primary key used as order number.
(1, 1, 3), (1, 2, 2),
-- Order 2 :
(2, 1, 3),
-- Order 3 :
(3, 2, 5), (3, 1, 7),
-- Order 4 :
(4, 1, 1), (4, 2, 3);

-- Display the 'order_items' tables.
SELECT * FROM "order_items";

-- Display the last test.
SELECT
    "orders"."id", 
    "first_name", 
    "last_name",
    "donot_name",
    "quantity"
FROM "orders"
JOIN "order_items" 
    ON "order_items"."order_id" = "orders"."id"
JOIN "customers" ON "customers"."id" = "orders"."customer_id"
JOIN "donots" ON "donots"."id" = "order_items"."donot_id";
