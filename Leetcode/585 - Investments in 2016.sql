-- Problem number is 585 - Medium
-- https://leetcode.com/problems/investments-in-2016/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    ROUND(SUM(tiv_2016::DECIMAL), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(tiv_2015) > 1
) AND (lat+lon) IN (
    SELECT lat+lon
    FROM Insurance
    GROUP BY lat+lon
    HAVING COUNT(lat+lon) = 1
)
