-- Problem number is 619 - Easy
-- https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
-- SELECT on empty data brings NULL values
SELECT (
    SELECT num AS num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
    ORDER BY num DESC
    LIMIT 1
)
