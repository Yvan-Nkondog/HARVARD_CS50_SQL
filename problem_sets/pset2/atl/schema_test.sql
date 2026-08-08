-- Uses atl.db

-- Clean the database before creating the tables.
DROP TABLE IF EXISTS "checkins";
DROP TABLE IF EXISTS "flights";
DROP TABLE IF EXISTS "airline_concourses";
DROP TABLE IF EXISTS "passengers";
DROP TABLE IF EXISTS "airlines";
DROP TABLE IF EXISTS "concourses";


-- Create a table for passengers, that satisfies the
-- required specifications.
CREATE TABLE "passengers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL CHECK ("age" > 0),
    PRIMARY KEY("id")
);

-- Create a table for check-ins, that satisfies the
-- required specifications.
CREATE TABLE "checkins" (
    "id" INTEGER,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "checkin_datetime" NUMERIC NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M', 'now')),
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id") ON DELETE CASCADE,
    FOREIGN KEY("flight_id") REFERENCES "flights"("id") ON DELETE CASCADE
);

-- Create a table for airlines, that satisfies the
-- required specifications.
CREATE TABLE "airlines" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Create a table for concourses (for normalizing data).
CREATE TABLE "concourses" (
    "id" INTEGER,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'E', 'F', 'T')),
    PRIMARY KEY("id")
);

-- Create a table to join airlines and concourses (normalization).
CREATE TABLE "airline_concourses" (
    "id" INTEGER,
    "airline_id" INTEGER NOT NULL,
    "concourse_id" INTEGER NOT NULL,
    PRIMARY KEY("id"), 
    FOREIGN KEY ("airline_id") REFERENCES "airlines"("id") ON DELETE CASCADE,
    FOREIGN KEY ("concourse_id") REFERENCES "concourses"("id") ON DELETE CASCADE
);

-- Create a table for flights, that satisfies the
-- required specifications.
CREATE TABLE "flights" (
    "id" INTEGER,
    "airline_id" INTEGER,
    "flight_number" NUMERIC,
    "departing_airport" TEXT NOT NULL,
    "heading_airport" TEXT NOT NULL,
    "departure_datetime" NUMERIC NOT NULL,
    "arrival_datetime" NUMERIC NOT NULL, 
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id") ON DELETE CASCADE,
    CHECK ("arrival_datetime" > "departure_datetime")
);


-- Insert values into the tables.
INSERT INTO "passengers" ("first_name", "last_name", "age")
VALUES 
('Amelia', 'Earhart', 39),
('John', 'Doe', 18),
('Jane', '', 5);

SELECT * FROM "passengers";


-- Insert into airlines
INSERT INTO "airlines"("name")
VALUES
('DELTA'),
('AIR CANADA'),
('AIR TRANSAT'),
('AIR FRANCE'),
('BRUXELLE AIRWAYS');

-- Insert into concourse (table filled once globally,
-- except if there are new concourses to add later).
INSERT INTO "concourses"("concourse")
VALUES
('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('T'); 

-- Link the airlines to the concourses.
INSERT INTO "airline_concourses"("airline_id", "concourse_id")
VALUES
-- 'DELTA'
(1, 1), (1, 2), (1, 3), (1, 4), (1, 7),
-- 'AIR CANADA'
(2, 1), (2, 2), (2, 3), (2, 4), (2, 7),
-- 'AIR TRANSAT'
(3, 5), (3, 6), (3, 7),
-- 'AIR FRANCE'
(4, 2), (4, 3), (4, 5), (4, 7),
-- 'BRUXELLE'S AIRWAYS'
(5, 1), (5, 5), (5, 6), (5, 7);

-- Display the tables.
SELECT * FROM "airlines";
SELECT * FROM "concourses";
SELECT * FROM "airline_concourses";

SELECT *
FROM "airlines"
JOIN "airline_concourses" ON "airline_concourses"."airline_id" = "airlines"."id"
JOIN "concourses" ON "concourses"."id" = "airline_concourses"."concourse_id"
WHERE "airlines"."name" = 'DELTA';


-- Insert data into "flights" table.
INSERT INTO "flights"("airline_id", "flight_number", "departing_airport", 
                    "heading_airport", "departure_datetime", "arrival_datetime")
VALUES
(1, 300, 'ATL', 'BOS', '2023-08-03 18:46', '2023-08-03 21:09'),
(2, 500, 'YUL', 'ATL', '2024-07-02 11:17', '2024-07-03 14:02');

-- Display the table.
SELECT * FROM "flights";


-- Insert into the checkins table
INSERT INTO "checkins" ("passenger_id", "flight_id", "checkin_datetime")
VALUES
(1, 1, '2023-08-03 15:03');

INSERT INTO "checkins" ("passenger_id", "flight_id")
VALUES
(1, 1),
(2, 2),
(3, 1);

-- Display the table.
SELECT * FROM "checkins";
