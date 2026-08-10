-- In this SQL file, write (and comment!) the schema of your database, 
-- including the CREATE TABLE, CREATE INDEX, CREATE VIEW, 
-- etc. statements that compose it.


-- The database to be created is a university course management system.
-- (ucm.db).

-- Delete tables on initialization.
DROP TABLE IF EXISTS "class_schedules";
DROP TABLE IF EXISTS "enrollments";
DROP TABLE IF EXISTS "courses";
DROP TABLE IF EXISTS "professors";
DROP TABLE IF EXISTS "departments";
DROP TABLE IF EXISTS "students";

-- Table containing the list of departments of the
-- university.
CREATE TABLE "departments" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Table representing the list of professors of the 
-- university.
CREATE TABLE "professors" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "department_id" INTEGER,
    "email" TEXT NOT NULL UNIQUE
        CHECK("email" LIKE '_%@_%._%'),
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"("id") ON DELETE CASCADE
);

-- Table representing the list of courses in the
-- university.
CREATE TABLE "courses" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "department_id" INTEGER,
    "credits" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"("id") ON DELETE CASCADE
);

-- Table representing the list of students in the
-- university.
CREATE TABLE "students" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "department_id" INTEGER,
    "email" TEXT NOT NULL UNIQUE
        CHECK("email" LIKE '_%@_%._%'),
    PRIMARY KEY("id")
);

-- Table realising the link between students and courses
-- in the university.
CREATE TABLE "enrollments" (
    "id" INTEGER,
    "student_id" INTEGER,
    "course_id" INTEGER,
    "grade" TEXT CHECK ("grade" IN ('A', 'B', 'C', 'D', 'F', NULL)),
    PRIMARY KEY("id")
    FOREIGN KEY("student_id") REFERENCES "students"("id") ON DELETE CASCADE,
    FOREIGN KEY("course_id") REFERENCES "courses"("id") ON DELETE CASCADE
);

-- Table representing the class schedules.
CREATE TABLE "class_schedules" (
    "id" INTEGER,
    "professor_id" INTEGER,
    "course_id" INTEGER,
    "semester" TEXT NOT NULL CHECK ("semester" IN ('Fall', 'Winter', 'Spring', 'Summer')),
    "year" INTEGER NOT NULL CHECK ("year" > 0),
    PRIMARY KEY("id"),
    FOREIGN KEY("professor_id") REFERENCES "professors"("id") ON DELETE CASCADE,
    FOREIGN KEY("course_id") REFERENCES "courses"("id") ON DELETE CASCADE
);


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Create indices for statements that users commonly run.
DROP INDEX IF EXISTS "professor_name_search";
CREATE INDEX "professor_name_search" ON "professors"("first_name", "last_name");

DROP INDEX IF EXISTS "student_name_search";
CREATE INDEX "student_name_search" ON "students"("first_name", "last_name");

DROP INDEX IF EXISTS "course_credit_search";
CREATE INDEX "course_credit_search" ON "courses"("credits");

DROP INDEX IF EXISTS "class_schedule_year_semester_search";
CREATE INDEX "class_schedule_year_semester_search" ON "class_schedules"("year", "semester");
