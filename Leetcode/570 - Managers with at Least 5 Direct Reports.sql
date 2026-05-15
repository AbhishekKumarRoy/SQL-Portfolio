-- Problem number is 570 - Medium
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT e1.name
FROM Employee e
INNER JOIN Employee e1 ON e.managerId = e1.id
GROUP BY 
  e1.id, 
  e1.name
HAVING COUNT(e1.id) > 4
