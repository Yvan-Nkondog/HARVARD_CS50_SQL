-- Your team is working on archiving old data. In 2.sql, 
-- write a SQL query to find the names of districts 
-- that are no longer operational.

-- Districts that are no longer operational have 
-- “(non-op)” at the end of their name.

-- Uses dese.db

SELECT "name"
FROM "districts"
WHERE "name" LIKE '%(non-op)';
