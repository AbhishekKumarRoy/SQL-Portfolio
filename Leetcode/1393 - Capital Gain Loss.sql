-- Problem number is 1393 - Medium
-- https://leetcode.com/problems/capital-gainloss/description/

-- Solution 1
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


-- Solution 2
-- Write your PostgreSQL query statement below
SELECT
    stock_name,
    SUM(price) FILTER(WHERE operation = 'Sell') - 
    SUM(price) FILTER(WHERE operation = 'Buy') AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
