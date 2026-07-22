-- Problem number is 1393 - Medium
-- https://leetcode.com/problems/capital-gainloss/description/

-- Write your PostgreSQL query statement below
SELECT
    stock_name,
    SUM(
        CASE
            WHEN operation = 'Buy'
            THEN -1 * price ELSE price
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
