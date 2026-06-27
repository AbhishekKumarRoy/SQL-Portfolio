-- Problem number is 1484 - Easy
-- https://leetcode.com/problems/group-sold-products-by-the-date/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STRING_AGG(DISTINCT product, ',') AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date
