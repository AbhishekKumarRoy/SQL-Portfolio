-- Problem number is 1741 - Easy
-- https://leetcode.com/problems/find-total-time-spent-by-each-employee/description/

-- Write your PostgreSQL query statement below
SELECT 
    event_day AS day,
    emp_id,
    SUM(out_time - in_time) AS total_time
FROM Employees
GROUP BY 
    event_day,
    emp_id
