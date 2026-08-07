-- Drop the table triplets.
DROP TABLE IF EXISTS "triplets";

-- Create a table to store the triplets.
CREATE TABLE "triplets" (
    "id" INTEGER,
    "sentence_id" INTEGER,
    "character_position" INTEGER,
    "message_length" INTEGER,
    PRIMARY KEY("id")
);


-- Fill the table with the encoded solution given
-- in the question.
INSERT INTO "triplets"("sentence_id", "character_position", "message_length")
VALUES 
(14, 98, 4),
(114, 3, 5),
(618, 72, 9),
(630, 7, 3),
(932, 12, 5),
(2230, 50, 7),
(2346, 44, 10),
(3041, 14, 5);


-- Delete any existing view name "message".
DROP VIEW IF EXISTS "message";

-- Create the view according to the specified condition.
CREATE VIEW "message" AS
SELECT substr("sentence", "character_position", "message_length") AS "phrase"
FROM "sentences"
JOIN "triplets" ON "triplets"."sentence_id" = "sentences"."id";
