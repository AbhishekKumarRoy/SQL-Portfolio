-- Top Earners - Easy
-- https://www.hackerrank.com/challenges/earnings-of-employees/problem

WITH cte AS (
    SELECT 
        months * salary AS total, 
        COUNT(months * salary) AS num
    FROM Employee
    GROUP BY months * salary
    ORDER BY 
        total DESC, 
        COUNT(*) DESC
)

SELECT CONCAT(total, ' ', num)
FROM cte
LIMIT 1
