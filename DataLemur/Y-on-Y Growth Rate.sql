-- Sourced from Wayfair - Hard
-- https://datalemur.com/questions/yoy-growth-rate

WITH total_spend_by_product_per_year AS (
  SELECT 
    product_id,
    DATE_PART('YEAR', transaction_date) AS year,
    SUM(spend) AS total_spend
  FROM user_transactions
  GROUP BY 
    product_id,
    DATE_PART('YEAR', transaction_date)
)
SELECT 
  year,
  product_id,
  total_spend AS curr_year_spend,
  LAG(total_spend) OVER(
    PARTITION BY product_id
    ORDER BY year ASC
  ) AS prev_year_spend,
  ROUND(
    100.00*(total_spend::DECIMAL - LAG(total_spend) OVER(
      PARTITION BY product_id
      ORDER BY year ASC
    ))/LAG(total_spend) OVER(
      PARTITION BY product_id
      ORDER BY year ASC
    ), 2
  ) AS yoy_rate
FROM total_spend_by_product_per_year
ORDER BY 
  product_id ASC,
  year ASC
; 
