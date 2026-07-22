-- Write a SQL query to explore a question of your choice. 
-- This query should: Involve at least one condition, 
-- using WHERE with AND or OR

-- Uses cyberchase.db

-- The proposed query searches into the database, cyberchase,
-- titles (and topics) for which the corresponding topics are 
-- related to the keywords 'data', 'analysis', and 'engineer'.

SELECT "title", "topic" FROM "episodes"
WHERE "topic" LIKE '%data%' OR '%analysis%' OR '%engineer%';
