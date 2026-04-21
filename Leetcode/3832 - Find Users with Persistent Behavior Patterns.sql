# Problem 3832
# https://leetcode.com/problems/find-users-with-persistent-behavior-patterns/description/

# Using "Gaps and Island" to find the consecutive logins
WITH first AS (
    SELECT 
        user_id,
        action_date,
        MAX(action) AS action
    FROM activity
    GROUP BY 
        user_id,
        action_date
    HAVING COUNT(user_id) = 1
),

sec AS (
    SELECT 
        user_id,
        action_date,
        action,
        DATE_ADD(
            action_date, INTERVAL - ROW_NUMBER() OVER(
                PARTITION BY user_id, action_date
                ORDER BY action_date
            ) DAY
        ) AS grouped
    FROM first
),

streak AS (
    SELECT 
        user_id,
        action,
        COUNT(user_id) AS streak_length,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date
    FROM sec
    GROUP BY 
        user_id,
        action
    HAVING COUNT(user_id) > 4
)

SELECT 
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM streak
WHERE (user_id, streak_length) IN (
    SELECT user_id, MAX(streak_length)
    FROM streak
    GROUP BY user_id
)
ORDER BY 
    streak_length DESC,
    user_id ASC
