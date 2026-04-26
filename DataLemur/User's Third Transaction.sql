# Sourced from Uber - Medium
# https://datalemur.com/questions/sql-third-transaction

WITH cte AS (
  SELECT 
    user_id,
    spend,
    transaction_date,
    ROW_NUMBER() OVER(
      PARTITION BY user_id ORDER BY transaction_date ASC
    ) AS rnk
  FROM transactions
)
SELECT 
  user_id,
  spend,
  transaction_date
FROM cte
WHERE rnk = 3
;
