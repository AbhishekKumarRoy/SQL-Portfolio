-- Sourced from Alibaba - Medium
-- https://datalemur.com/questions/alibaba-compressed-mode

WITH cte AS (
  SELECT 
    item_count,
    DENSE_RANK() OVER(ORDER BY order_occurrences DESC) AS rnk
  FROM items_per_order
)
SELECT item_count
FROM cte
WHERE rnk = 1
ORDER BY item_count ASC
;
