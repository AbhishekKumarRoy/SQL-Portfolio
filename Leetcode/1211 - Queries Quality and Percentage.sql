-- The problem number is 1211 - Easy
-- https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    query_name,
    ROUND(
        AVG(rating/position::DECIMAL), 2
    ) AS quality,
    ROUND(
        100.00 * COUNT(rating) FILTER(WHERE rating < 3)/COUNT(rating), 2
    ) AS poor_query_percentage
FROM Queries
GROUP BY query_name
