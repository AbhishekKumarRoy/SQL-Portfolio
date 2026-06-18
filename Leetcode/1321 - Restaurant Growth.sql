-- Problem number is 1321 - Medium
-- https://leetcode.com/problems/restaurant-growth/description/

--1)
-- Write your MySQL query statement below
WITH cte AS (
    SELECT 
        visited_on,
        SUM(amount) OVER(
            ORDER BY visited_on ASC
            RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW    
        ) AS amount
    FROM Customer
)

SELECT 
    visited_on,
    amount,
    ROUND(amount/7, 2) AS average_amount
FROM cte
WHERE visited_on >= DATE_ADD((
    SELECT MIN(visited_on)
    FROM Customer), INTERVAL 6 DAY
)
GROUP BY visited_on
ORDER BY visited_on ASC


-- 2)    
-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),
cte2 AS (
    SELECT 
        visited_on,
        SUM(amount) OVER(
            ORDER BY visited_on ASC
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        ROUND(AVG(amount) OVER(
            ORDER BY visited_on ASC
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2) AS average_amount
    FROM cte
)

SELECT 
    visited_on,
    amount,
    average_amount
FROM cte2
WHERE visited_on > (
        SELECT MIN(visited_on) FROM cte2
    ) + INTERVAL '5 DAYS'
ORDER BY visited_on ASC
