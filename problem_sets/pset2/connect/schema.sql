
-- Delete all existing tables.
DROP TABLE IF EXISTS "user_company_connections";
DROP TABLE IF EXISTS "user_school_connections";
DROP TABLE IF EXISTS "user_user_connections";
DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "schools";
DROP TABLE IF EXISTS "companies";


-- Create tables according to the specifications.
CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "schools" (
    "id" INTEGER,
    "school_name" TEXT NOT NULL,
    "school_type" TEXT NOT NULL,
    "school_location" TEXT NOT NULL,
    "founded" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "companies" (
    "id" INTEGER,
    "company_name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "company_location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "user_user_connections" (
    "id" INTEGER,
    "user1_id" INTEGER NOT NULL,
    "user2_id" INTEGER NOT NULL,
    "connection_type" TEXT DEFAULT 'friend',
    "user_connection_datetime" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY kEY("id"),
    FOREIGN KEY("user1_id") REFERENCES users("id") ON DELETE CASCADE,
    FOREIGN KEY("user2_id") REFERENCES users("id") ON DELETE CASCADE,
    -- Constraint to prevent self connection and to order the pairs
    -- avoiding reverse duplication.
    CHECK ("user1_id" < "user2_id"),
    -- No same connection should exist twice.
    CONSTRAINT "unique_connection" UNIQUE ("user1_id", "user2_id")
);

CREATE TABLE "user_school_connections" (
    "id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "school_id" INTEGER NOT NULL,
    "school_start_datetime" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "school_end_datetime" NUMERIC,
    "degree_type" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("school_id") REFERENCES "schools"("id") ON DELETE CASCADE,
    CHECK (
        "school_end_datetime" IS NULL
        OR "school_start_datetime" < "school_end_datetime"
        )
);

CREATE TABLE "user_company_connections" (
    "id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "company_start_datetime" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "company_end_datetime" NUMERIC,
    "job_title" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("company_id") REFERENCES "companies"("id") ON DELETE CASCADE,
    CHECK (
        "company_end_datetime" IS NULL
        OR "company_start_datetime" < "company_end_datetime"
        )
);
