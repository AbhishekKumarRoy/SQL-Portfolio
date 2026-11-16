-- Challenges - Medium
-- https://github.com/AbhishekKumarRoy/SQL-Portfolio/new/main/HackerRank

WITH cte AS (SELECT 
    h.hacker_id,
    h.name,
    COUNT(c.challenge_id) AS total
FROM Hackers h
INNER JOIN Challenges c ON h.hacker_id = c.hacker_id
GROUP BY 
    h.hacker_id,
    h.name
)

SELECT *
FROM cte
WHERE total NOT IN (
    SELECT 
        total
    FROM cte
    GROUP BY total
    HAVING COUNT(*) > 1
) OR total = (
    SELECT MAX(total)
    FROM cte
)
ORDER BY 
    total DESC,
    hacker_id
