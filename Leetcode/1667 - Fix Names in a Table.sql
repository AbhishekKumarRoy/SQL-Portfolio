-- Problem number is 1667 - Easy
-- https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    CONCAT(
        UPPER(LEFT(name, 1)), LOWER(SUBSTR(name, 2))
    ) AS name
FROM Users
ORDER BY user_id
