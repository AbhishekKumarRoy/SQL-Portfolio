# Sourced from TikTok - Medium
# https://datalemur.com/questions/signup-confirmation-rate

SELECT 
  ROUND(
    1.0 * COUNT(e.user_id) FILTER(WHERE t.signup_action = 'Confirmed')/
    COUNT(*), 2
  ) AS confirm_rate
FROM emails e 
INNER JOIN texts t ON e.email_id = t.email_id
