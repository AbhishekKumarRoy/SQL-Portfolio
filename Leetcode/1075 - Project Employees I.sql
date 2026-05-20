-- Problem number is 1075 - Easy
-- https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    p.project_id,
    ROUND(
        AVG(e.experience_years), 2
    ) AS average_years
FROM Project p
INNER JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id
