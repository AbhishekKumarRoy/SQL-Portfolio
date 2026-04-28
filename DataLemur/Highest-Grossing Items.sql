# Sourced from Amazaon - Medium
# https://datalemur.com/questions/sql-highest-grossing

WITH cte AS (
  SELECT 
    category,
    product,
    SUM(spend) AS total_spend,
    RANK() OVER(
      PARTITION BY category ORDER BY SUM(spend) DESC
    ) AS rnk
  FROM product_spend
  WHERE DATE_PART('YEAR', transaction_date::DATE) = '2022'
  GROUP BY 
    category,
    product
)
SELECT 
  category,
  product,
  total_spend
FROM cte 
WHERE rnk < 3 # Little faster than <= 2
;
