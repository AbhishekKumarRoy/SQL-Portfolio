-- Problem number is 1251 - Easy
-- https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    p.product_id,
    ROUND(
        -- Using COALESCE to replace NULL with 0
        COALESCE(
            1.00 * SUM(p.price * u.units)/SUM(u.units), 0
        ), 2
    ) AS average_price
FROM Prices p
-- Using LEFT JOIN to get all products including the ones which are not sold
LEFT JOIN UnitsSold u ON p.product_id = u.product_id
WHERE u.purchase_date BETWEEN p.start_date 
    AND p.end_date OR u.purchase_date IS NULL
GROUP BY p.product_id
