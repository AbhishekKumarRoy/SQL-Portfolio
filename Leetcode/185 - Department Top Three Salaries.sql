-- Problem number is 185 - Hard
-- https://leetcode.com/problems/department-top-three-salaries/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER(
            PARTITION BY d.name
            ORDER BY e.salary DESC
        ) AS rnk
    FROM Employee e
    INNER JOIN Department d ON e.departmentId = d.id
)
SELECT 
    Department,
    Employee,
    Salary
FROM cte
WHERE rnk < 4
