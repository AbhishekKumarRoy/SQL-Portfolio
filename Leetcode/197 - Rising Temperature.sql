-- Problem number is 197 - Easy
-- https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT w1.id
FROM Weather w
INNER JOIN Weather w1 ON (w1.recordDate - w.recordDate) = 1
WHERE w1.temperature > w.temperature
