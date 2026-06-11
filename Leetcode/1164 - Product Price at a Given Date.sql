-- Problem number is 1164 - Medium
-- https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    product_id,
    new_price AS price
FROM Products
WHERE (product_id, change_date) IN (
    SELECT 
        product_id,
        MAX(change_date) AS max_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)
UNION
SELECT 
    product_id,
    10 AS price
FROM Products
WHERE product_id NOT IN (
    SELECT 
        product_id
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)
