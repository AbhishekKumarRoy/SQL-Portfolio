-- Problem number is 626 - Medium
-- https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    CASE
        WHEN id = (SELECT MAX(id) FROM Seat) AND id % 2 <> 0
        THEN id
        WHEN id % 2 <> 0 
        THEN id + 1
        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id ASC
