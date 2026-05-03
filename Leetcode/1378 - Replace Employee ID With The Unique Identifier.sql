-- Problem number is 1378 - Easy
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    em.unique_id,
    e.name
FROM Employees e
LEFT JOIN EmployeeUNI em ON e.id = em.id
