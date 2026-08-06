

SELECT * FROM "courses" LIMIT 1;
SELECT * FROM "enrollments" LIMIT 1;
SELECT * FROM "requirements" LIMIT 1;
SELECT * FROM "satisfies" LIMIT 1;
SELECT * FROM "students" LIMIT 1;


-- The optimization for this question is going to be
-- handled using typical queries given in the questions.


-- Typical query 1 :
-- Find a student’s historical course enrollments, based on their ID:

-- Query analysis :

--      a) The "student"."id" in "WHERE" clause is already a primary key (no new index needed).
--      b) An index is needed to handle "enrollments"."course_id"  and
--         "enrollments"."student_id" (new index needed).
--      c) The right hand sides of the "JOIN" clauses already use primary keys, 
--         hence no action required to search "courses"."id" and "student"."id". 

-- Delete the index for this query.
DROP INDEX IF EXISTS "index_enrollments_courses";

-- Create index based on each query analysis.
CREATE INDEX "index_enrollments_courses"
ON "enrollments"("course_id");

EXPLAIN QUERY PLAN
SELECT "courses"."title", "courses"."semester"
FROM "enrollments"
JOIN "courses" ON "enrollments"."course_id" = "courses"."id"
JOIN "students" ON "enrollments"."student_id" = "students"."id"
WHERE "students"."id" = 3;


-- Typical query 2
-- Find all students who enrolled in Computer Science 50 in Fall 2023:

-- Query analysis :

--      a) The "student"."id" in "WHERE" clause is already a primary key (no new index needed).
--      b) An index is required to handle "enrollments"."course_id". The corresponding composite
--         index in query 1 is reused.
--      c) A composite index "courses"("department", "number", "semester"); is required to speed the
--         most internal subquery. However, A second index involving course, from <typical query 5> : 
--         "courses"("semester", "title") has been created later. Hence the semester column has been removed
--         to optimize the use of space and find the best space-time tradeoff.

-- Delete the index for this query.
DROP INDEX IF EXISTS "index_courses_department_number";

-- Create index based on query analysis.
CREATE INDEX "index_courses_department_number"
ON "courses"("department", "number");

EXPLAIN QUERY PLAN
SELECT "id", "name"
FROM "students"
WHERE "id" IN (
    SELECT "student_id"
    FROM "enrollments"
    WHERE "course_id" = (
        SELECT "id"
        FROM "courses"
        WHERE "courses"."department" = 'Computer Science'
        AND "courses"."number" = 50
        AND "courses"."semester" = 'Fall 2023'
    )
);


-- Typical query 3
-- Sort courses by most- to least-enrolled in Fall 2023:

-- Query analysis :

--      a) The index for "courses"("semester") is handled by the correspondint index  
--         "courses"("semester", "title") created later for <typical query 5>.
--      b) The index for "enrollments"("course_id") is handled by the corresponding index
--         "enrollments"("course_id") previously created for <typical query 1>.
--      No need to create new indices for <typical query 3>, based on complete analysis of the
--      <typical queries>.

EXPLAIN QUERY PLAN
SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title", COUNT(*) AS "enrollment"
FROM "courses"
JOIN "enrollments" ON "enrollments"."course_id" = "courses"."id"
WHERE "courses"."semester" = 'Fall 2023'
GROUP BY "courses"."id"
ORDER BY "enrollment" DESC;


-- Typical query 4
-- Find all computer science courses taught in Spring 2024:

-- Query analysis :

--         A composite index "courses"("department", "semester") is required. However this
--         index is handled by the correspondint indices "courses"("department", "number")
--         previously created in <typical query 2> and "courses"("semester", "title") created 
--         later for <typical query 5>. No need of additional index.

EXPLAIN QUERY PLAN
SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title"
FROM "courses"
WHERE "courses"."department" = 'Computer Science'
AND "courses"."semester" = 'Spring 2024';


-- Typical query 5
-- Find the requirement satisfied by “Advanced Databases” in Fall 2023:

-- Query analysis :

--      a) The "requirements"."id" in "WHERE" clause is already a primary key (no new index needed).
--      b) The "satisfies"."course_id" in  the subquery scans rows and requires the creation of an index
--         ON "satisfies"("course_id").
--      c) To be more efficient (time), an composite index (used as covering index) 
--         "courses"("semester", "title") is required.

-- Delete the indices for this query.
DROP INDEX IF EXISTS "index_satisfies_course";
DROP INDEX IF EXISTS "index_courses_semester_title";

-- Create indices based on query analysis.
CREATE INDEX "index_courses_semester_title"
ON "courses"("semester", "title");
-- Add an index to satisfies.cours_id to speed up the query.
CREATE INDEX "index_satisfies_course"
ON "satisfies"("course_id");

EXPLAIN QUERY PLAN
SELECT "requirements"."name"
FROM "requirements"
WHERE "requirements"."id" = (
    SELECT "requirement_id"
    FROM "satisfies"
    WHERE "course_id" = (
        SELECT "id"
        FROM "courses"
        WHERE "title" = 'Advanced Databases'
        AND "semester" = 'Fall 2023'
    )
);


-- Typical query 6
-- Find how many courses in each requirement a student has satisfied:

-- Query analysis :

--      a) The "satisfies"."course_id" in the "WHERE" clause of the principal query reuses the
--         same index created from <typical query 5> ON "satisfies"("course_id").
--      b) An index is required ON "enrollment"("student_id"). 
--      c) The primary key on requirements is used as index for the JOIN statement.

-- Delete the index for this query.
DROP INDEX IF EXISTS "index_enrollments_student";

-- Create index based on each query analysis.
CREATE INDEX "index_enrollments_student"
ON "enrollments"("student_id");

EXPLAIN QUERY PLAN
SELECT "requirements"."name", COUNT(*) AS "courses"
FROM "requirements"
JOIN "satisfies" ON "requirements"."id" = "satisfies"."requirement_id"
WHERE "satisfies"."course_id" IN (
    SELECT "course_id"
    FROM "enrollments"
    WHERE "enrollments"."student_id" = 8
)
GROUP BY "requirements"."name";


-- Typical query 7
-- Search for a course by title and semester:

-- Query analysis :

--      The composite query ON "courses"("semester", "title") from <typical query 5>
--      has been reused. No new index created.

EXPLAIN QUERY PLAN
SELECT "department", "number", "title"
FROM "courses"
WHERE "title" LIKE 'History%'
AND "semester" = 'Fall 2023';
