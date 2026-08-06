-- Problem number is 3436 - Easy
-- https://leetcode.com/problems/find-valid-emails/description/

-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    email
FROM users
WHERE email ~ '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$'
ORDER BY user_id;
