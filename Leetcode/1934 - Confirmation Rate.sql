-- Problem number is 1934 - Medium
-- https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    s.user_id,
    ROUND(
        -- Using Average to get the percentage
        AVG(
            CASE
                WHEN c.action = 'confirmed' 
                THEN 1.00 ELSE 0.00
            END
        ), 2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
