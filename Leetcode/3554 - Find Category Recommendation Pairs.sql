-- Problem number is 3554 - Hard
-- https://leetcode.com/problems/find-category-recommendation-pairs/description/

-- Write your PostgreSQL query statement below
WITH combined_tables AS (
    SELECT 
        p.user_id,
        pi.category AS category1,
        pi2.category AS category2
    FROM ProductPurchases p
    INNER JOIN ProductPurchases p1 ON p.user_id = p1.user_id 
    INNER JOIN ProductInfo pi ON p.product_id = pi.product_id
    INNER JOIN ProductInfo pi2 ON p1.product_id = pi2.product_id
        AND pi.category < pi2.category
    WHERE pi.category <> pi2.category 
    GROUP BY
        p.user_id,
        pi.category,
        pi2.category
)
SELECT 
    category1,
    category2,
    COUNT(*) AS customer_count
FROM combined_tables
GROUP BY 
    category1,
    category2
HAVING COUNT(*) > 2
ORDER BY
    customer_count DESC,
    LOWER(category1) ASC,
    LOWER(category2) ASC
