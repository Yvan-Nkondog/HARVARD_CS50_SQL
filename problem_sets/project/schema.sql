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


-- Polutate the tables :

-- Populate departments
INSERT INTO "departments" ("id", "name") 
VALUES
(1, 'Computer Science And Software Engineering'),
(2, 'Mathematics'),
(3, 'Chemistry'),
(4, 'Electrical And Computer Engineering'),
(5, 'Physics');

-- Populate professors
INSERT INTO "professors" ("id", "first_name", "last_name", "department_id", "email") 
VALUES
(1, 'Jane', 'Smith', 1, 'jane.smith@univ.edu'),
(2, 'John', 'Doe', 2, 'john.doe@univ.edu'),
(3, 'Michael', 'Williams', 3, 'michael.williams@univ.edu'),
(4, 'Estelle', 'Snow', 4, 'estelle.snow@univ.edu'),
(5, 'Justine', 'Gregoire', 5, 'justine.gregoire@univ.edu');

-- Populate courses
INSERT INTO "courses" ("id", "name", "department_id", "credits") 
VALUES
(1, 'Intro to Programming', 1, 4),
(2, 'Electrical and Numerical Circuits', 4, 3),
(3, 'Calculus I', 2, 4),
(4, 'Waves and Optics', 5, 3),
(5, 'Sustainable Devolopment', 3, 3);

-- Populate students
INSERT INTO "students" ("id", "first_name", "last_name", "department_id", "email") 
VALUES
(1, 'Serena', 'Yellow', 1, 'serena.yellow@univ.edu'),
(2, 'Jeremy', 'Stolenlies', 2, 'jeremy.stolenlies@univ.edu'),
(3, 'Gerard', 'Davids', 3, 'Gerard.davids@univ.edu'),
(4, 'Thomas', 'Rodgers', 4, 'thomas.rodgers@univ.edu'),
(5, 'Lina', 'Vue', 5, 'lina.vue@univ.edu'),
(6, 'Simon', 'Samson', 1, 'simon.samson@univ.edu');

-- Populate enrollments
INSERT INTO "enrollments" ("id", "student_id", "course_id", "grade") 
VALUES
(1, 1, 1, 'A'),
(2, 1, 2, 'B'),
(3, 2, 3, 'A'),
(4, 3, 4, 'C'),
(5, 4, 5, 'B'),
(6, 5, 1, 'A'),
(7, 5, 2, 'A'),
(8, 2, 4, 'A'),
(9, 3, 5, 'A'),
(10, 4, 4, 'B');

-- Populate class_schedules
INSERT INTO "class_schedules" ("id", "professor_id", "course_id", "semester", "year") 
VALUES
(1, 1, 1, 'Fall',   2024),
(2, 5, 2, 'Spring', 2024),
(3, 2, 3, 'Winter', 2022),
(4, 4, 4, 'Summer', 2020),
(5, 3, 5, 'Fall',   2021);

