-- Sourced from Facebook - Hard
-- https://datalemur.com/questions/updated-status

SELECT 
  CASE  
    WHEN a.user_id IS NULL
    THEN d.user_id ELSE a.user_id
  END AS user_id,
  CASE
    WHEN a.status = 'NEW' AND d.paid IS NOT NULL
    THEN 'EXISTING'
    WHEN a.status = 'NEW' AND d.paid IS NULL
    THEN 'CHURN'
    WHEN a.status = 'EXISTING' AND d.paid IS NOT NULL
    THEN 'EXISTING'
    WHEN a.status = 'EXISTING' AND d.paid IS NULL
    THEN 'CHURN'
    WHEN a.status = 'CHURN' AND d.paid IS NOT NULL
    THEN 'RESURRECT'
    WHEN a.status = 'CHURN' AND d.paid IS NULL
    THEN 'CHURN'
    WHEN a.status = 'RESURRECT' AND d.paid IS NOT NULL
    THEN 'EXISTING'
    WHEN a.status = 'RESURRECT' AND d.paid IS NULL
    THEN 'CHURN'
    WHEN a.user_id IS NULL AND d.user_id IS NOT NULL
    THEN 'NEW'
  END AS new_status
FROM advertiser a
FULL OUTER JOIN daily_pay d ON a.user_id = d.user_id
ORDER BY user_id;

