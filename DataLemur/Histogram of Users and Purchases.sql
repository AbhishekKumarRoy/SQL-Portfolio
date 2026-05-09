-- Sourced from Walmart - Medium
-- https://datalemur.com/questions/histogram-users-purchases

SELECT 
  transaction_date,
  user_id,
  COUNT(user_id) AS purchase_count
FROM user_transactions
WHERE (user_id, transaction_date) IN (
  SELECT 
    user_id,
    MAX(transaction_date) 
  FROM user_transactions
  GROUP BY user_id
)
GROUP BY 
  transaction_date,
  user_id
ORDER BY 
  transaction_date ASC,
  user_id ASC,
  purchase_count ASC;
