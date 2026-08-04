-- Users need to be prevented from re-opening a message that 
-- has expired. Find when the message with ID 151 expires. 
-- You may use the message’s ID directly in your query.

--      Ensure your query uses the index automatically created 
--      on the primary key column of the messages table.

-- Uses snap.db


-- Execute the query
SELECT "expires_timestamp"
FROM "messages"
WHERE "id" = 151;

-- Explain the query plan
EXPLAIN QUERY PLAN
SELECT "expires_timestamp"
FROM "messages"
WHERE "id" = 151;


