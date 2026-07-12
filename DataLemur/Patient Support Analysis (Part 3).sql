-- Sourced from United Health - Hard
-- https://datalemur.com/questions/patient-call-history

WITH call_history AS (
  SELECT 
    policy_holder_id,
    ROUND(EXTRACT(EPOCH FROM call_date 
      - LAG(call_date) OVER (
  	    PARTITION BY policy_holder_id ORDER BY call_date)
    )/(24*60*60),2) AS time_diff_days
  FROM callers
)

SELECT COUNT(DISTINCT policy_holder_id) AS policy_holder_count
FROM call_history
WHERE time_diff_days <= 7;
