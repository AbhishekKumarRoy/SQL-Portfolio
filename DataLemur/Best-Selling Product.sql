-- Sourced from Amazon - Medium
-- https://datalemur.com/questions/best-selling-products

WITH top_sales AS (
  SELECT 
    p.category_name,
    p.product_name,
    DENSE_RANK() OVER(
      PARTITION BY category_name ORDER BY ps.sales_quantity DESC, ps.rating DESC
    ) AS rnk
  FROM products p
  INNER JOIN product_sales ps ON p.product_id = ps.product_id
)

SELECT 
  category_name,
  product_name
FROM top_sales
WHERE rnk = 1
ORDER BY 
  category_name,
  product_name
;
