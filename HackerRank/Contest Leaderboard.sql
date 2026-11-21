-- Contest Leaderboard - Medium
-- https://www.hackerrank.com/challenges/contest-leaderboard/problem

WITH max_score AS (
    SELECT
        s.hacker_id,
        h.name,
        s.challenge_id,
        MAX(s.score) AS score
    FROM Submissions s
    INNER JOIN Hackers h ON s.hacker_id = h.hacker_id
    GROUP BY 
        s.hacker_id,
        h.name,
        s.challenge_id    
)

SELECT 
    hacker_id,
    name,
    SUM(score) AS total_sum
FROM max_score
GROUP BY 
    hacker_id,
    name
HAVING SUM(score) > 0
ORDER BY 
    total_sum DESC,
    hacker_id ASC
