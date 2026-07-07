-- Problem number is 182 - Easy
-- https://leetcode.com/problems/duplicate-emails/description/

-- Write your PostgreSQL query statement below
SELECT email
FROM Person 
GROUP BY email
HAVING COUNT(email) > 1
