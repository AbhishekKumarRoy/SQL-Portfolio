-- Problem number is 608 - Medium
-- https://leetcode.com/problems/tree-node/description/

-- Write your PostgreSQL query statement below
SELECT 
    id,
    CASE
        WHEN p_id is NULL 
        THEN 'Root'
        WHEN id IN (
            SELECT p_id
            FROM Tree
        )
        THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree
