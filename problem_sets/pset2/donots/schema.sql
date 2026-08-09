
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
