-- Problem number is 180 - Medium
-- https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
-- Using CTE
WITH cte AS (
    SELECT 
        id,
        num,
        LAG(num) OVER(ORDER BY id ASC) AS prev,
        LEAD(num) OVER(ORDER BY id ASC) AS next
    FROM Logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM cte
WHERE prev = num AND num = next


-- Using Joins
SELECT DISTINCT l.num AS ConsecutiveNums
FROM Logs l
INNER JOIN Logs l1 ON l.id = l1.id + 1
INNER JOIN Logs l2 ON l.id = l2.id + 2
WHERE l.num = l1.num AND l1.num = l2.num
