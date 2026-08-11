-- Problem number is 3497 - Medium
-- https://leetcode.com/problems/analyze-subscription-conversion/description/

-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    ROUND(AVG(activity_duration) FILTER(
        WHERE activity_type = 'free_trial'
    ), 2) AS trial_avg_duration,
    ROUND(AVG(activity_duration) FILTER(
        WHERE activity_type = 'paid'
    ), 2) AS paid_avg_duration
FROM UserActivity
WHERE user_id IN (
    SELECT user_id
    FROM UserActivity
    WHERE activity_type <> 'cancelled'
    GROUP BY user_id
    HAVING COUNT(DISTINCT activity_type) = 2
)
GROUP BY user_id
ORDER BY user_id ASC
