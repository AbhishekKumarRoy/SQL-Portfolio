-- Problem number is 184 - Medium
-- https://leetcode.com/problems/department-highest-salary/description/

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        e.name AS Employee,
        e.salary AS Salary,
        d.name AS Department,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) AS rnk
    FROM Employee e
    INNER JOIN Department d ON e.departmentId = d.id
)

SELECT 
    Department,
    Employee,
    Salary
FROM cte
WHERE rnk = 1
