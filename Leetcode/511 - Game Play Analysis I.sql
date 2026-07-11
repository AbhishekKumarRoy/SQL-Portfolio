-- Problem number is 511 - Easy
-- https://leetcode.com/problems/game-play-analysis-i/description/

-- Write your PostgreSQL query statement below
SELECT 
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id
