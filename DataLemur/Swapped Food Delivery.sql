-- Sourced from Zomato - Medium
-- https://datalemur.com/questions/sql-swapped-food-delivery
-- There are two solutions: 1) Using Subquery and 2) Using CTE

-- 1) Subquery
SELECT 
  CASE
    WHEN order_id % 2 != 0 AND order_id != (SELECT MAX(order_id) FROM orders)
    THEN order_id + 1
    WHEN order_id % 2 = 0
    THEN order_id - 1
    ELSE order_id
  END AS corrected_order_id,
  item
FROM orders 
ORDER BY corrected_order_id ASC
;


-- 2) CTE
WITH cte AS (
  SELECT COUNT(order_id) AS total_orders 
  FROM orders
)

SELECT
  CASE
    WHEN order_id % 2 != 0 AND order_id != cte THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = cte THEN order_id
    ELSE order_id - 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN order_counts
ORDER BY corrected_order_id;
