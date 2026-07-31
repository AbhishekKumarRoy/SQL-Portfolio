-- Problem number is 1890 - Easy
-- https://leetcode.com/problems/the-latest-login-in-2020/description/

-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    MAX(time_stamp) AS last_stamp
FROM Logins
WHERE DATE_PART('YEAR', time_stamp) = 2020
GROUP BY user_id
