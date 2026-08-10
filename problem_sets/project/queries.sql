-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database


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
INSERT INTO "students" (id, first_name, last_name, department_id, email) VALUES
(1, 'Serena', 'Yellow', 1, 'serena.yellow@univ.edu'),
(2, 'Jeremy', 'Stolenlies', 2, 'jeremy.stolenlies@univ.edu'),
(3, 'Gerard', 'Davids', 3, 'Gerard.davids@univ.edu'),
(4, 'Thomas', 'Rodgers', 4, 'Thomas.rodgers@univ.edu'),
(5, 'Lina', 'Vue', 5, 'Lina.Vue@.univ.edu');

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
(2, 1, 2, 'Spring', 2024),
(3, 2, 3, 'Winter', 2022),
(4, 3, 4, 'Summer', 2020),
(5, 4, 5, 'Fall',   2021);


SELECT * FROM "students";
SELECT * FROM "professors";
SELECT * FROM "courses";
SELECT * FROM "departments";
SELECT * FROM "enrollments";
SELECT * FROM "class_schedules";

-- Display student names and grades per course
