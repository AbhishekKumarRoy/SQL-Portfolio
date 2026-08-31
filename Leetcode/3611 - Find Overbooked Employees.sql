-- Problem number is 3611 - Medium
-- https://leetcode.com/problems/find-overbooked-employees/description/

-- Write your PostgreSQL query statement below
WITH total_hours AS (
    SELECT 
        employee_id,
        -- Using DATE_TRUNC because it count weeks from Monday to Sunday
        DATE_TRUNC('WEEK', meeting_date) AS weeks,
        SUM(duration_hours) AS total_meeting_hours
    FROM meetings
    GROUP BY   
        employee_id,
        DATE_TRUNC('WEEK', meeting_date),
        DATE_TRUNC('YEAR', meeting_date)   
    HAVING SUM(duration_hours) > 20
)

SELECT 
    e.employee_id,
    e.employee_name,
    e.department,
    COUNT(t.employee_id) AS meeting_heavy_weeks
FROM employees e
INNER JOIN total_hours t ON e.employee_id = t.employee_id
GROUP BY 
    e.employee_id,
    e.employee_name,
    e.department
HAVING COUNT(t.employee_id) > 1
ORDER BY 
    meeting_heavy_weeks DESC,
    employee_name ASC
