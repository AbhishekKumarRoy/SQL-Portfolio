-- Problem number is 3808 - Medium
-- https://leetcode.com/problems/find-emotionally-consistent-users/

-- Write your PostgreSQL query statement below
WITH total_per_reaction AS (
    SELECT 
        user_id,
        reaction,
        COUNT(reaction) AS total_count,
        ROW_NUMBER() OVER(
            PARTITION BY user_id
            ORDER BY COUNT(reaction) DESC
        ) AS ranking
    FROM reactions
    WHERE user_id IN (
        SELECT user_id
        FROM reactions
        GROUP BY user_id
        HAVING COUNT(DISTINCT content_id) > 4
    )
    GROUP BY
        user_id,
        reaction
),
ratio AS (
    SELECT 
        user_id,
        ROUND(
            MAX(total_count)::DECIMAL/SUM(total_count)::DECIMAL, 2
        ) AS reaction_ratio
    FROM total_per_reaction 
    GROUP BY user_id
    HAVING ROUND(
        MAX(total_count)::DECIMAL/SUM(total_count)::DECIMAL, 2
    ) >= 0.60
)

SELECT 
    t.user_id,
    t.reaction AS dominant_reaction,
    r.reaction_ratio
FROM total_per_reaction t
INNER JOIN ratio m ON t.user_id = r.user_id
WHERE t.ranking = 1
ORDER BY 
    reaction_ratio DESC,
    user_id ASC
