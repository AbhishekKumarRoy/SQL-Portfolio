-- Problem number is 1661 - Easy
-- https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT 
        machine_id,
        process_id,
        SUM(
            CASE
                WHEN activity_type = 'end'
                THEN timestamp
                ELSE -1.0 * timestamp
            END
        ) AS time_taken
    FROM Activity
    GROUP BY machine_id, process_id
)
SELECT 
    machine_id,
    ROUND(
        AVG(time_taken::DECIMAL), 3 -- Converting time_taken to decimal, else it will be Integer which will cause an error.
    ) AS processing_time
FROM cte
GROUP BY machine_id
