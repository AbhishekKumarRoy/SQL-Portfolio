-- Sourced from Amazon - Medium
-- https://datalemur.com/questions/amazon-shopping-spree

SELECT DISTINCT t.user_id
FROM transactions t
INNER JOIN transactions t1 ON t.user_id = t1.user_id 
  AND DATE(t.transaction_date) = DATE(t1.transaction_date) + 1
INNER JOIN transactions t2 ON t.user_id = t2.user_id
  AND DATE(t.transaction_date) = DATE(t2.transaction_date) + 2
