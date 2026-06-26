-- Problem number is 176 - Medium
-- https://leetcode.com/problems/second-highest-salary/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        id,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM Employee
)
SELECT (
    SELECT DISTINCT salary AS SecondHighestSalary
    FROM cte
    WHERE rnk = 2
)
