-- Problem number is 601 - Hard
-- https://leetcode.com/problems/human-traffic-of-stadium/

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        id,
        visit_date,
        people,
        id - ROW_NUMBER() OVER(ORDER BY id ASC) AS diff
    FROM Stadium
    WHERE people > 99
)
SELECT 
    id,
    visit_date,
    people
FROM cte
WHERE diff IN (
    SELECT diff
    FROM cte
    GROUP BY diff
    HAVING COUNT(diff) > 2
)
ORDER BY visit_date ASC
