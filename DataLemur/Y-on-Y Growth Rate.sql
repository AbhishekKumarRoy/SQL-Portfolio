-- Sourced from Wayfair - Hard
-- https://datalemur.com/questions/yoy-growth-rate

WITH total_spend_per_year_by_product AS (
  SELECT 
    product_id,
    DATE_PART('YEAR', transaction_date) AS year,
    SUM(spend) AS total_spend
  FROM user_transactions
  GROUP BY product_id, DATE_PART('YEAR', transaction_date)
),
with_lag AS (
  SELECT
    year,
    product_id,
    total_spend AS curr_year_spend,
    LAG(total_spend) OVER (
      PARTITION BY product_id ORDER BY year
    ) AS prev_year_spend
  FROM total_spend_per_year_by_product
)
SELECT
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  ROUND(
    100.00 * (curr_year_spend::DECIMAL - prev_year_spend) / prev_year_spend,
  2) AS yoy_rate
FROM with_lag
ORDER BY 
  product_id ASC, 
  year ASC;
