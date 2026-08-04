-- The app needs to send users a summary of their 
-- engagement. Find the username of the most popular 
-- user, defined as the user who has had the most messages 
-- sent to them.

--      Ensure your query uses the search_messages_by_to_user_id index, 
--      which is defined as follows:

--      CREATE INDEX "search_messages_by_to_user_id"
--      ON "messages"("to_user_id");

-- Uses snap.db


-- Delete existing index.
DROP INDEX IF EXISTS "search_messages_by_to_user_id";

-- Create the index mentioned in the question.
CREATE INDEX "search_messages_by_to_user_id"
ON "messages"("to_user_id");

-- Execute the query
SELECT "username"
FROM "users"
WHERE "id" IN (
    SELECT "to_user_id"
    FROM "messages"
    GROUP BY "to_user_id"
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- Explain the query plan
EXPLAIN QUERY PLAN
SELECT "username"
FROM "users"
WHERE "id" IN (
    SELECT "to_user_id"
    FROM "messages"
    GROUP BY "to_user_id"
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Commented below, is a second version of the query,
-- which is applicable to the case where many users
-- have the same number of received messages (maximum value).
-- The version proposed above is based on the content of the
-- "Advice" section, found in the html page of the exercise.


-- -- Execute the query
-- SELECT "username"
-- FROM "users"
-- WHERE "id" IN (
--     SELECT "to_user_id"
--     FROM "messages"
--     GROUP BY "to_user_id"
--     HAVING COUNT(*) = (
--         SELECT MAX("received_message_count")
--         FROM (
--             SELECT COUNT(*) AS "received_message_count"
--             FROM "messages"
--             GROUP BY "to_user_id"
--         )
--     )
-- );


-- -- Explain the query plan
-- EXPLAIN QUERY PLAN
-- SELECT "username"
-- FROM "users"
-- WHERE "id" IN (
--     SELECT "to_user_id"
--     FROM "messages"
--     GROUP BY "to_user_id"
--     HAVING COUNT(*) = (
--         SELECT MAX("received_message_count")
--         FROM (
--             SELECT COUNT(*) AS "received_message_count"
--             FROM "messages"
--             GROUP BY "to_user_id"
--         )
--     )
-- );
