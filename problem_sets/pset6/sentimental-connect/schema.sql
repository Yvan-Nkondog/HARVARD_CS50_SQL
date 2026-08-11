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
