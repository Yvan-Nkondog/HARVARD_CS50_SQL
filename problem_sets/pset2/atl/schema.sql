-- Uses atl.db

-- Clean the database before creating the tables.
DROP TABLE IF EXISTS "passengers";
DROP TABLE IF EXISTS "checkins";
DROP TABLE IF EXISTS "airlines";
DROP TABLE IF EXISTS "flights";

-- Create a table for passengers, that satisfies the
-- required specifications.
CREATE TABLE "passengers" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "age" INTEGER,
    PRIMARY KEY("id")
);

-- Create a table for check-ins, that satisfies the
-- required specifications.
CREATE TABLE "checkins" (
    "id" INTEGER,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "datetime" NUMERIC NON NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);

-- Create a table for airlines, that satisfies the
-- required specifications.
CREATE TABLE "airlines" (
    "id" INTEGER,
    "name" TEXT NON NULL,
    "concourse" TEXT NON NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'E', 'F', 'T'))
);

-- Create a table for flights, that satisfies the
-- required specifications.
CREATE TABLE "flights" (
    "id" INTEGER,
    "airline_id" INTEGER,
    "flight_number" NUMERIC,
    "departing_airport" TEXT NON NULL UNIQUE,
    "heading_airport" TEXT NON NULL UNIQUE,
    "departure_datatime" NUMERIC NOT NULL CHECK (
        'departure_datetime' GLOB '____-__-__ __:__'
    ),
    "arrival_datetime" NUMERIC NOT NULL CHECK (
        'arrival_datetime' GLOB '____-__-__ __:__'
    ),
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);
