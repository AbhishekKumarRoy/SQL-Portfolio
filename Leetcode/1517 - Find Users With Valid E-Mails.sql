-- Problem number is 1517 - Easy
-- https://leetcode.com/problems/find-users-with-valid-e-mails/description/

-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    name,
    mail
FROM Users
WHERE mail ~ '^[a-zA-Z]+[a-zA-Z0-9_.-]*@leetcode\.com$'
