-- The problem number is 1193 - Medium
-- https://leetcode.com/problems/monthly-transactions-i/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(id) AS trans_count,
    COUNT(id) FILTER(WHERE state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    -- Using COALESCE to replace NULL with 0
    COALESCE(
        SUM(amount) FILTER(WHERE state = 'approved'), 0
    ) AS approved_total_amount
FROM Transactions
GROUP BY 
    TO_CHAR(trans_date, 'YYYY-MM'),
    country
