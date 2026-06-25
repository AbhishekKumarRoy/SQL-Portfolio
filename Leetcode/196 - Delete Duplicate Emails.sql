-- Problem number is 196 - Easy
-- https://leetcode.com/problems/delete-duplicate-emails/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
DELETE FROM Person p1
USING Person p2
WHERE p1.id > p2.id AND p1.email = p2.email
