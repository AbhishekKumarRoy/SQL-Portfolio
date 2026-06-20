-- Sourced from Google - Hard
-- https://datalemur.com/questions/median-search-freq

WITH Cumulative AS (
    SELECT searches, 
           num_users,
           SUM(num_users) OVER (ORDER BY searches) AS running_total,
           SUM(num_users) OVER () AS total_users
    FROM search_frequency
)
SELECT ROUND(AVG(searches), 1) AS median
FROM Cumulative
WHERE running_total BETWEEN (total_users + 1) / 2 AND total_users / 2 + 1;
