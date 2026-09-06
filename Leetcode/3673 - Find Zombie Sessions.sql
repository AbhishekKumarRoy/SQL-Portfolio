-- Problem number is 3673 - Hard
-- https://leetcode.com/problems/find-zombie-sessions/description/

-- Write your PostgreSQL query statement below
SELECT 
    session_id,
    user_id,
    (MAX(EXTRACT(EPOCH FROM event_timestamp)) - 
        MIN(EXTRACT(EPOCH FROM event_timestamp)))/60 AS session_duration_minutes,
    COUNT(event_type) FILTER(WHERE event_type = 'scroll') AS scroll_count
FROM app_events
WHERE (user_id, session_id) NOT IN(
    SELECT 
        user_id,
        session_id
    FROM app_events
    WHERE event_type = 'purchase'
)
GROUP BY 
    session_id,
    user_id
HAVING 
    (MAX(EXTRACT(EPOCH FROM event_timestamp)) - 
    MIN(EXTRACT(EPOCH FROM event_timestamp)))/60 > 30
    AND
    COUNT(event_type) FILTER(WHERE event_type = 'scroll') > 4
    AND
    COUNT(event_type) FILTER(WHERE event_type = 'click')::DECIMAL/
    COUNT(event_type) FILTER(WHERE event_type = 'scroll')::DECIMAL < 0.20
ORDER BY 
    scroll_count DESC,
    session_id ASC
