-- Problem number is 1731 - Easy
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    e.employee_id,
    e.name,
    COUNT(e1.employee_id) AS reports_count,
    ROUND(
        AVG(e1.age), 0
    ) AS average_age
FROM Employees e
INNER JOIN Employees e1 ON e.employee_id = e1.reports_to
GROUP BY 
    e.employee_id,
    e.name
ORDER BY e.employee_id ASC
