# 1321. Restaurant Growth
# Write your MySQL query statement below
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
