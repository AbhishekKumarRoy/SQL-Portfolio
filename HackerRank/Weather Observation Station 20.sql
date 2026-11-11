-- Weather Observation Station 20 - Medium
-- https://www.hackerrank.com/challenges/weather-observation-station-20/problem

WITH cte AS (
    SELECT 
        LAT_N,
        ROW_NUMBER() OVER(
            ORDER BY LAT_N ASC
        ) AS rnk_asc,
        ROW_NUMBER() OVER(
            ORDER BY LAT_N DESC
        ) AS rnk_desc       
    FROM STATION
)

SELECT ROUND(AVG(LAT_N), 4)
FROM cte
WHERE ABS(
    CAST(rnk_asc AS SIGNED) - CAST(rnk_desc AS SIGNED)
    ) <= 1
