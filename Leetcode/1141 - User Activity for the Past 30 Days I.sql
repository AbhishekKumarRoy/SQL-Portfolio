-- Problem number is 1141 - Easy
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-07-27'::DATE - INTERVAL '29 DAYS' 
    AND '2019-07-27'
GROUP BY activity_date
