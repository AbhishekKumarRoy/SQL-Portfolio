-- Problem number is 3580 - Medium
-- https://leetcode.com/problems/find-consistently-improving-employees/description/

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        e.employee_id,
        e.name,
        p.rating,
        ROW_NUMBER() OVER(
            PARTITION BY e.employee_id
            ORDER BY p.review_date DESC
        ) AS rnk
    FROM employees e
    INNER JOIN performance_reviews p ON e.employee_id = p.employee_id
),
cte1 AS (
    SELECT 
        employee_id,
        name,
        MAX(CASE
            WHEN rnk = 1 THEN rating
        END) AS latest,
        MAX(CASE
            WHEN rnk = 2 THEN rating
        END) AS middle,
        MAX(CASE
            WHEN rnk = 3 THEN rating
        END) AS oldest  
    FROM cte
    GROUP BY 
        employee_id, 
        name
    HAVING COUNT(rnk) > 2
)

SELECT 
    employee_id,
    name, 
    latest - oldest AS improvement_score
FROM cte1
WHERE latest > middle 
    AND middle > oldest 
    AND latest > oldest
ORDER BY 
    improvement_score DESC,
    name ASC
