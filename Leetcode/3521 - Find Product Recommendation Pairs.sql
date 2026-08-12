-- Problem number is 3521 - Medium
-- https://leetcode.com/problems/find-product-recommendation-pairs/description/

-- Write your PostgreSQL query statement below
SELECT 
    p.product_id AS product1_id,
    p1.product_id AS product2_id,
    pi.category AS product1_category,
    pi1.category AS product2_category,
    COUNT(DISTINCT p.user_id) AS customer_count
FROM ProductPurchases p 
INNER JOIN ProductPurchases p1 ON p.product_id < p1.product_id
    AND p.user_id = p1.user_id
INNER JOIN ProductInfo pi ON p.product_id = pi.product_id
INNER JOIN ProductInfo pi1 ON p1.product_id = pi1.product_id
GROUP BY 
    p.product_id,
    p1.product_id,
    pi.category,
    pi1.category
HAVING COUNT(DISTINCT p.user_id) > 2
ORDER BY 
    customer_count DESC,
    product1_id ASC,
    product2_id ASC
