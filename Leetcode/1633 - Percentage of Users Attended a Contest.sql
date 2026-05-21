-- Problem number is 1633 - Easy
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    contest_id,
    ROUND(
        100.00 * COUNT(user_id)/(
            SELECT COUNT(user_id) 
            FROM Users
        ), 2
     ) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY 
    percentage DESC,
    contest_id ASC
