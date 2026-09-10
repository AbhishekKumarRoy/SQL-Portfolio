-- Problem number is 3832 - Hard
-- https://leetcode.com/problems/find-users-with-persistent-behavior-patterns/description/

-- Write your PostgreSQL query statement below
WITH one_action_per_day AS (
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
find_consecutive_days AS (
	SELECT 
        user_id, 
        action_date, 
        action,
	    action_date - CAST( row_number() OVER(
            PARTITION BY user_id 
            ORDER BY action_date
        ) AS INT) AS group_action_date
	FROM one_action_per_day
), 
filter_streak AS (
	SELECT 
        user_id, 
        action, 
	    MIN(action_date) AS start_date,
	    MAX(action_date) AS end_date,
	    COUNT(user_id) AS streak_length
	FROM find_consecutive_days
	GROUP BY 
        user_id, 
        action, 
        group_action_date
	HAVING COUNT(user_id) > 4
)
SELECT 
    user_id,   
    action, 
    streak_length, 
    start_date, 
    end_date
FROM filter_streak f
WHERE streak_length >= (
    SELECT MAX(streak_length) 
    FROM filter_streak f1 
    WHERE f.user_id = f1.user_id
)
ORDER BY 
    streak_length DESC, 
    user_id ASC


    
-- MySQL
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
