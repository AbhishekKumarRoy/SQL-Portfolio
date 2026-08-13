-- Problem number is 3564 - Medium
-- https://leetcode.com/problems/seasonal-sales-analysis/description/

-- Write your PostgreSQL query statement below
WITH seasons AS (
    SELECT
        CASE
            WHEN DATE_PART('month', s.sale_date) IN (12, 1, 2)
            THEN 'Winter'
            WHEN DATE_PART('month', s.sale_date) IN (3, 4, 5)
            THEN 'Spring'
            WHEN DATE_PART('month', s.sale_date) IN (6, 7, 8)
            THEN 'Summer' ELSE 'Fall'
        END AS season,
        s.product_id,
        s.quantity,
        s.price,
        p.category
    FROM sales s
    INNER JOIN products p ON s.product_id = p.product_id
), 
seasons_rnk AS (   
    SELECT 
        season,
        category,
        SUM(quantity) AS total_quantity,
        SUM(quantity * price) AS total_revenue,
        RANK() OVER(
            PARTITION BY season
            ORDER BY 
                SUM(quantity) DESC, 
                SUM(quantity * price) DESC, 
                category ASC
        ) AS rnk
    FROM seasons
    GROUP BY 
        season,
        category
)

SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM seasons_rnk
WHERE rnk = 1
ORDER BY season ASC
