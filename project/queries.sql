-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Polutate the tables :

-- Populate the table departments
INSERT OR IGNORE INTO "departments" ("id", "name") 
VALUES
(1, 'Computer Science And Software Engineering'),
(2, 'Mathematics'),
(3, 'Chemistry'),
(4, 'Electrical And Computer Engineering'),
(5, 'Physics');

-- Populate the table professors
INSERT OR IGNORE INTO "professors" ("id", "first_name", "last_name", "department_id", "email") 
VALUES
(1, 'Jane', 'Smith', 1, 'jane.smith@univ.edu'),
(2, 'John', 'Doe', 2, 'john.doe@univ.edu'),
(3, 'Michael', 'Williams', 3, 'michael.williams@univ.edu'),
(4, 'Estelle', 'Snow', 4, 'estelle.snow@univ.edu'),
(5, 'Justine', 'Gregoire', 5, 'justine.gregoire@univ.edu');

-- Populate the table courses
INSERT OR IGNORE INTO "courses" ("id", "name", "department_id", "credits") 
VALUES
(1, 'Intro to Programming', 1, 4),
(2, 'Electrical and Numerical Circuits', 4, 3),
(3, 'Calculus I', 2, 4),
(4, 'Waves and Optics', 5, 3),
(5, 'Sustainable Devolopment', 3, 3);

-- Populate the table students
INSERT OR IGNORE INTO "students" ("id", "first_name", "last_name", "department_id", "email") 
VALUES
(1, 'Serena', 'Yellow', 1, 'serena.yellow@univ.edu'),
(2, 'Jeremy', 'Stolenlies', 2, 'jeremy.stolenlies@univ.edu'),
(3, 'Gerard', 'Davids', 3, 'Gerard.davids@univ.edu'),
(4, 'Thomas', 'Rodgers', 4, 'thomas.rodgers@univ.edu'),
(5, 'Lina', 'Vue', 5, 'lina.vue@univ.edu'),
(6, 'Simon', 'Samson', 1, 'simon.samson@univ.edu');

-- Populate the table enrollments
INSERT OR IGNORE INTO "enrollments" ("id", "student_id", "course_id", "grade") 
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

-- Populate the table class_schedules
INSERT OR IGNORE INTO "class_schedules" ("id", "professor_id", "course_id", "semester", "year") 
VALUES
(1, 1, 1, 'Fall',   2024),
(2, 5, 2, 'Spring', 2024),
(3, 2, 3, 'Winter', 2022),
(4, 4, 4, 'Summer', 2020),
(5, 3, 5, 'Fall',   2021);


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------


-- Common queries

-- 1. Search a professor by first name and last name.
-- This query is useful as many people search on internet by names
-- and do not have access to "id" values from the database. It also
-- gives access to the university's email of the professor 
-- (which is usually public).
SELECT 
    "professors"."first_name",
    "professors"."last_name",
    "departments"."name" AS "department",
    "professors"."email"
FROM "professors"
JOIN "departments" ON "professors"."department_id" = "departments"."id"
WHERE "professors"."first_name" = 'Michael' AND "professors"."last_name" = 'Williams'
ORDER BY "professors"."first_name" ASC, "professors"."last_name" ASC;

-- 2. Search a student by first_name and last_name.
-- This query is useful when the "id" of the student is unknown. This happens
-- often in the real world. The "email" has not been included because student's
-- email are not usually public. 
SELECT 
    "students"."first_name",
    "students"."last_name",
    "departments"."name" AS "department"
FROM  "students"
JOIN "departments" ON  "students"."department_id" = "departments"."id"
WHERE "students"."first_name" = 'Serena' AND "students"."last_name" = 'Yellow'
ORDER BY  "students"."first_name" ASC, "students"."last_name" ASC;

-- 3. List all courses with departments a specified number of credits.
-- This query helps students to decide in which courses they enroll,
-- based on the number of credits.
SELECT 
    "courses"."name" AS "course name",
    "departments"."name" AS "department",
    "credits"
FROM "courses"
JOIN "departments" ON "courses"."department_id" = "departments"."id"
WHERE "credits" = 3
ORDER BY "departments"."name" ASC, "courses"."name" ASC;

-- 4. Show all class schedules with professors for a given year and for a given semester.
-- This query is helpful for professors, as they can use them to check
-- the course they have to teach for a given semester.
SELECT
    "class_schedules"."id",
    "professors"."first_name" || ' ' || "professors"."last_name" AS "professor's name",
    "courses"."name" AS "course name",
    "class_schedules"."semester",
    "class_schedules"."year"
FROM "class_schedules"
JOIN "professors" ON "class_schedules"."professor_id" = "professors"."id"
JOIN "courses" ON "class_schedules"."course_id" = "courses"."id"
WHERE "class_schedules"."year" = 2024 
AND "class_schedules"."semester" = 'Spring';
