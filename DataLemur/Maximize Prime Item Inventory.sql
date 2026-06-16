-- Sourced from Amazon - Hard
-- https://datalemur.com/questions/prime-warehouse-storage

WITH cte AS (
  SELECT
    item_type,
    SUM(square_footage) AS total_sqft,
    COUNT(*) AS item_count
  FROM inventory
  GROUP BY item_type
), 
cte2 AS (
  SELECT 
    item_type,
    total_sqft,
    FLOOR(500000/total_sqft) AS prime_item_comb_count,
    FLOOR(500000/total_sqft)*item_count AS prime_item_count
  FROM cte
  WHERE item_type = 'prime_eligible'
)

SELECT 
  item_type,
  CASE  
    WHEN item_type = 'prime_eligible'
    THEN FLOOR(500000/total_sqft)*item_count
    ELSE FLOOR((500000 - (
      SELECT FLOOR(500000/total_sqft) * total_sqft FROM cte2
    )) / total_sqft) * item_count
  END AS item_count
FROM cte
ORDER BY item_count DESC
;
