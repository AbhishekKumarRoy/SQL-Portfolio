-- Problem number is 181 - Easy
-- https://leetcode.com/problems/employees-earning-more-than-their-managers/description/

-- Write your PostgreSQL query statement below
SELECT 
    e1.name AS Employee
FROM Employee e
INNER JOIN Employee e1 ON e.id = e1.managerId
WHERE e1.salary > e.salary
