-- Problem number is 550 - Medium
-- https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    ROUND(
        1.00 * COUNT(player_id)/(
            SELECT COUNT(DISTINCT player_id)
            FROM Activity
        ), 2
    ) AS fraction
FROM Activity
WHERE (player_id, event_date) IN (
    SELECT 
        player_id,
        MIN(event_date) + INTERVAL '1 DAY'
    FROM Activity
    GROUP BY player_id
)
