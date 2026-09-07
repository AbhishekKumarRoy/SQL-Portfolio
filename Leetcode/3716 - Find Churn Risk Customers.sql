-- Problem number is 3716 - Medium
-- https://leetcode.com/problems/find-churn-risk-customers/

-- Write your PostgreSQL query statement below
WITH current AS (
    SELECT 
        user_id,
        event_date,
        event_type,
        plan_name,
        monthly_amount,
        DENSE_RANK() OVER(
            PARTITION BY user_id
            ORDER BY event_date DESC
        ) AS max_row_number  
    FROM subscription_events
), user_group AS (
    SELECT 
        user_id,
        MAX(monthly_amount) AS max_historical_amount,
        MAX(event_date) - MIN(event_date) AS days_as_subscriber
    FROM subscription_events
    GROUP BY user_id
    HAVING COUNT(event_type) FILTER(WHERE event_type = 'downgrade') > 0
)

SELECT 
    c.user_id,
    c.plan_name AS current_plan,
    c.monthly_amount AS current_monthly_amount,
    u.max_historical_amount,
    u.days_as_subscriber
FROM current c
INNER JOIN user_group u ON c.user_id = u.user_id
WHERE c.max_row_number = 1
    AND c.user_id NOT IN(
        SELECT user_id
        FROM current
        WHERE max_row_number = 1 AND event_type = 'cancel'
    )
    AND c.monthly_amount::DECIMAL/u.max_historical_amount::DECIMAL < 0.50
    AND u.days_as_subscriber > 59
ORDER BY 
    days_as_subscriber DESC,
    user_id ASC
