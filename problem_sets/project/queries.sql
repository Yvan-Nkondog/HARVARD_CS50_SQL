-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database


-- Common queries
-- 1 Represent all professors (alphabetical order) with their department names.
SELECT 
    "professors"."first_name",
    "professors"."last_name",
    "departments"."name" AS "department",
    "professors"."email"
FROM "professors"
JOIN "departments" ON "professors"."department_id" = "departments"."id"
ORDER BY "professors"."first_name" ASC, "professors"."last_name" ASC;


-- 2. Represent all students (alphabetical order) with their department names.
SELECT 
    "students"."first_name",
    "students"."last_name",
    "departments"."name" AS "department"
FROM  "students"
JOIN "departments" ON  "students"."department_id" = "departments"."id"
WHERE "departments"."id" = 1
ORDER BY  "students"."first_name" ASC, "students"."last_name" ASC;

-- 3. Represent all the enrollments, with students' first and last names, 
-- course, and grades. Note : Ideally, the following query should contain a 
-- "WHERE" clause by semester (and the extra corresponding JOIN), as students 
-- usually check their grades at the end of each semester. The "WHERE" clause has 
-- not been added based on  the current data available inside the database.

SELECT 
    "enrollments"."id",
    "students"."first_name",
    "students"."last_name",
    "courses"."name",
     "enrollments"."grade"
FROM "enrollments"
JOIN "students" ON "students"."id" = "enrollments"."student_id"
JOIN "courses" ON "courses"."id" = "enrollments"."course_id"
WHERE "students"."department_id" = 5
ORDER BY  "students"."first_name" ASC, "students"."last_name" ASC, "courses"."name" ASC;

-- 4. List all courses with departments and credits.
-- This query helps students to decide in which courses they enroll.

SELECT 
    "courses"."name" AS "course name",
    "departments"."name" AS "department",
    "credits"
FROM "courses"
JOIN "departments" ON "courses"."department_id" = "departments"."id"
ORDER BY "departments"."name" ASC, "courses"."name" ASC;


-- 5. Show all class schedules with professors for a given semester.
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
ORDER BY "class_schedules"."year" DESC, "class_schedules"."semester" ASC;

-- 6. Count the total number of students per department.
-- This query might be useful when the budget per department
-- is assigned.

SELECT
    "departments"."name" AS "department",
    COUNT("students"."id") AS "total number of students"
    FROM "departments"
    JOIN "students" ON "students"."department_id" = "departments"."id"
    GROUP BY "departments"."name"
    ORDER BY "total number of students";


-- 7. Find students who have not enrolled in any courses.
-- This query might useful to identify and contact students that
-- have not enrolled to check if they still wish to pursue a degree
-- in the school.
SELECT
    "students"."id",
    "students"."first_name" || ' ' || "students"."last_name" AS "student's name",
    "students"."email"
FROM "students"
LEFT JOIN "enrollments" ON "enrollments"."student_id" = "students"."id"
WHERE "enrollments"."id" IS NULL;
