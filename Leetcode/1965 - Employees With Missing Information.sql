-- Problem number is 1965 - Easy
-- https://leetcode.com/problems/employees-with-missing-information/description/

-- Write your PostgreSQL query statement below
SELECT employee_id
FROM Employees 
WHERE employee_id NOT IN(
    SELECT employee_id
    FROM Salaries
    WHERE salary IS NOT NULL
)
UNION 
SELECT employee_id
FROM Salaries
WHERE employee_id NOT IN(
    SELECT employee_id
    FROM Employees
    WHERE name IS NOT NULL
)
ORDER BY employee_id ASC
