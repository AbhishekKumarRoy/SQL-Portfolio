-- Problem number is 1204 - Medium
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        person_name,
        turn,
        SUM(weight) OVER(ORDER BY turn ASC) AS cum_sum
    FROM Queue
)
SELECT person_name
FROM cte
WHERE cum_sum <= 1000
ORDER BY turn DESC
LIMIT 1
