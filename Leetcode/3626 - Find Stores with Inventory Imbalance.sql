-- Problem number is 3626 - Medium
-- https://leetcode.com/problems/find-stores-with-inventory-imbalance/description/

-- Write your PostgreSQL query statement below
WITH most_expensive AS (
    SELECT 
        store_id,
        product_name,
        quantity,
        price
    FROM inventory
    WHERE (store_id, price) IN (
        SELECT 
            store_id,
            MAX(price)
        FROM inventory
        GROUP BY store_id
    )
),
least_expensive AS (
    SELECT 
        store_id,
        product_name,
        quantity,
        price
    FROM inventory
    WHERE (store_id, price) IN (
        SELECT 
            store_id,
            MIN(price)
        FROM inventory
        GROUP BY store_id
    )
)

SELECT 
    m.store_id,
    s.store_name,
    s.location,
    m.product_name AS most_exp_product,
    l.product_name AS cheapest_product,
    ROUND(l.quantity::DECIMAL/m.quantity::DECIMAL, 2) AS imbalance_ratio 
FROM most_expensive m
INNER JOIN least_expensive l ON m.store_id = l.store_id
INNER JOIN stores s ON m.store_id = s.store_id
WHERE m.store_id IN(
    SELECT store_id
    FROM inventory
    GROUP BY store_id
    HAVING COUNT(DISTINCT product_name) > 2
) AND m.quantity < l.quantity
ORDER BY 
    imbalance_ratio DESC,
    store_name ASC
