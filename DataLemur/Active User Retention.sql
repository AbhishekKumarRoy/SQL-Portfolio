-- Sourced from facebook - Hard
-- https://datalemur.com/questions/user-retention

SELECT
  DATE_PART('month', event_date) AS month,
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE 
  TO_CHAR(event_date, 'YYYY-MM') = '2022-07'
  AND user_id IN (
    SELECT user_id
    FROM user_actions
    WHERE TO_CHAR(event_date, 'YYYY-MM') = '2022-06'
)
GROUP BY DATE_PART('month', event_date); 
