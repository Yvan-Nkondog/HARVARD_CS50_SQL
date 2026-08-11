-- Delete all existing tables (in reverse dependency order).
DROP TABLE IF EXISTS `user_company_connections`;
DROP TABLE IF EXISTS `user_company_connections`;
DROP TABLE IF EXISTS `user_school_connections`;
DROP TABLE IF EXISTS `user_user_connections`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `schools`;
DROP TABLE IF EXISTS `companies`;


-- Create tables according to the specifications.
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(32) NOT NULL,
    `password` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `schools` (
    `id` INT AUTO_INCREMENT,
    `school_name` VARCHAR(32) NOT NULL,
    `school_type` VARCHAR(32) NOT NULL,
    `school_location` VARCHAR(32) NOT NULL,
    `founded` INT NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `companies` (
    `id` INT AUTO_INCREMENT,
    `company_name` VARCHAR(32) NOT NULL,
    `industry` VARCHAR(32) NOT NULL,
    `company_location` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `user_user_connections` (
    `id` INT AUTO_INCREMENT,
    `user1_id` INT NOT NULL,
    `user2_id` INT NOT NULL,
    `connection_type` VARCHAR(32) DEFAULT 'friend',
    `user_connection_datetime` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY kEY(`id`),
    FOREIGN KEY(`user1_id`) REFERENCES users(`id`) ON DELETE CASCADE,
    FOREIGN KEY(`user2_id`) REFERENCES users(`id`) ON DELETE CASCADE,
    -- Constraint to prevent self connection and to order the pairs
    -- avoiding reverse duplication.
    CHECK (`user1_id` < `user2_id`),
    -- No same connection should exist twice.
    CONSTRAINT `unique_connection` UNIQUE (`user1_id`, `user2_id`)
);

CREATE TABLE `user_school_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `school_id` INT NOT NULL,
    `school_start_datetime` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `school_end_datetime` DATETIME,
    `degree_type` VARCHAR(32),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY(`school_id`) REFERENCES `schools`(`id`) ON DELETE CASCADE,
    CHECK (
        `school_end_datetime` IS NULL
        OR `school_start_datetime` < `school_end_datetime`
        )
);

CREATE TABLE `user_company_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `company_id` INT NOT NULL,
    `company_start_datetime` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `company_end_datetime` DATETIME,
    `job_title` VARCHAR(32),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`) ON DELETE CASCADE,
    CHECK (
        `company_end_datetime` IS NULL
        OR `company_start_datetime` < `company_end_datetime`
        )
);


-- -------------------------------------------------------------------------------
-- Insert data and test the database.
-- -------------------------------------------------------------------------------


-- Part 1 : User-user connections.
-- Insert data into `users` table.
INSERT INTO `users` (`first_name`, `last_name`, `username`, `password`)
VALUES
('Alan', 'Garber', 'alan', 'password'),
('Reid', 'Hoffman', 'reid', 'password'),
('John', 'Doe', 'john', 'test'),
('Jane', 'Smith', 'jane', 'test2'),
('Victor', 'Luther', 'victor', 'test3');

-- Display the `users` table.
SELECT * FROM `users`;

-- Insert data into `user_user_connections` table.
INSERT INTO `user_user_connections` (`user1_id`, `user2_id`)
VALUES
(1, 2);

INSERT INTO `user_user_connections` (`user1_id`, `user2_id`, `user_connection_datetime`)
VALUES
(1, 3, '2022-06-17 07:20:25'),
(1, 4, '2021-10-22 05:47:12'),
(2, 3, '2023-07-27 08:29:47'),
(2, 4, '2020-01-14 17:32:10');

-- Display the `user_user_connections` table.
SELECT * FROM `user_user_connections`;


-- Part 2 : User-school connections.
-- Insert data into `schools` table.
INSERT INTO `schools` (`school_name`, `school_type`, `school_location`, `founded`)
VALUES
('Harvard University', 'University', 'Cambridge, MA', '1636'),
('MIT', 'University', 'Cambridge, MA', '1861');

-- Display information about the school Harvard University.
SELECT * FROM `schools` WHERE `school_name` = 'Harvard University';

-- Insert data into the `user_school_connections` table.
INSERT INTO `user_school_connections` (`user_id`, `school_id`, 
            `school_start_datetime`, `school_end_datetime`, `degree_type`)
VALUES
(1, 1, '2020-09-01', '2024-04-30', 'BA'),
(1, 2, '2024-09-01', '2025-06-30', 'MA'),
(1, 1, '2025-09-01', NULL, 'PhD'),
(2, 1, '1998-09-01', '2001-06-30', 'PhD'),
(3, 2, '2022-09-01', '2026-04-30', 'PhD');

-- Check whether schools can find their students.
SELECT `school_name`, `first_name`, `last_name`, `degree_type`, 
       `school_start_datetime`, `school_end_datetime`
FROM `user_school_connections`
JOIN `schools` ON `user_school_connections`.`school_id` = `schools`.`id`
JOIN `users` ON `user_school_connections`.`user_id` = `users`.`id`
WHERE `schools`.`id` = 1;

-- Check whether students can find their schools.
SELECT `first_name`, `last_name`, `school_name`, `degree_type`, 
    `school_start_datetime`, `school_end_datetime`
FROM `user_school_connections`
JOIN `schools` ON `user_school_connections`.`school_id` = `schools`.`id`
JOIN `users` ON `user_school_connections`.`user_id` = `users`.`id`
WHERE `users`.`id` = 1;


-- Part 3 : User-company affiliation
-- Insert values for part 3.
INSERT INTO `companies` (`company_name`, `industry`, `company_location`)
VALUES
('LinkedIn', 'Technology', 'Sunnyvale, CA'),
('Test_bank', 'Banking and Finance', 'New York, NY'),
('Harvard University', 'Education', 'Cambridge, MA'),
('MIT', 'Education', 'Cambridge, MA');

-- Display information about the companies.
SELECT * FROM `companies`;

-- Insert values into the `user_company_connections` table.
INSERT INTO `user_company_connections` (`user_id`, `company_id`, `company_start_datetime`, 
            `company_end_datetime`, `job_title`)
VALUES
(4, 1, '2015-04-01', '2018-12-31', 'Vice President'),
(4, 1, '2019-01-01', NULL, 'CEO and Chairman'),
(5, 2, '2017-04-12', '2023-12-31', 'Human Resource Advisor'),
(5, 1, '2024-01-01', '2025-12-31', 'Human Resource Director'),
(5, 1, '2026-01-01', NULL, 'Vice President'),
(1, 3, '2025-09-01', NULL, 'First Cycle Lecturer'),
(3, 4, '2024-09-01', NULL, 'First Cycle Lab. Supervisor'),
(3, 4, '2026-05-01', NULL, 'Lecturer');

-- Check whether companies can find their employees and former employees.
SELECT `company_name`, `first_name`, `last_name`, `job_title`, 
       `company_start_datetime`, `company_end_datetime`
FROM `user_company_connections`
JOIN `companies` ON `user_company_connections`.`company_id` = `companies`.`id`
JOIN `users` ON `user_company_connections`.`user_id` = `users`.`id`
WHERE `companies`.`id` = 1;

-- Check whether students can find their schools (actually companies here).
SELECT `first_name`, `last_name`, `company_name`, `job_title`, 
       `company_start_datetime`, `company_end_datetime`
FROM `user_company_connections`
JOIN `companies` ON `user_company_connections`.`company_id` = `companies`.`id`
JOIN `users` ON `user_company_connections`.`user_id` = `users`.`id`
WHERE `users`.`id` = 5;

-- Display all links between users and companies.
-- Note: PhD students are both workers and students in the current database.
SELECT `company_name`, `first_name`, `last_name`, `job_title`, 
       `company_start_datetime`, `company_end_datetime`
FROM `user_company_connections`
JOIN `companies` ON `user_company_connections`.`company_id` = `companies`.`id`
JOIN `users` ON `user_company_connections`.`user_id` = `users`.`id`;
