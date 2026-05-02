-- Problem number is 584 - Easy
-- https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL
