-- Problem number is 1158 - Medium
-- https://leetcode.com/problems/market-analysis-i/description/

-- Write your PostgreSQL query statement below
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(*) FILTER(
        WHERE DATE_PART('YEAR', o.order_date) = '2019'
    ) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.buyer_id
GROUP BY 
    u.user_id,
    u.join_date
ORDER BY u.join_date ASC
