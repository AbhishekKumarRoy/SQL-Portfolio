-- Problem number is 3793 - Easy
-- https://leetcode.com/problems/find-users-with-high-token-usage/description/

-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    COUNT(prompt) AS prompt_count,
    ROUND(AVG(tokens), 2) AS avg_tokens
FROM prompts
GROUP BY user_id
HAVING 
    COUNT(prompt) > 2 
    AND MAX(tokens) > ROUND(AVG(tokens), 2)
ORDER BY 
    avg_tokens DESC,
    user_id ASC
