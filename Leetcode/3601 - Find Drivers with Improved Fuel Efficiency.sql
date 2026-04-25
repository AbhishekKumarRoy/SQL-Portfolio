# The problem number is 3601 - Medium
# https://leetcode.com/problems/find-drivers-with-improved-fuel-efficiency/description/
# There are two solutions for this problem - one solved with CTE and another with Subquery

  
# CTE
WITH first AS (
    SELECT 
        driver_id,
        SUM(distance_km/fuel_consumed)/COUNT(driver_id) AS first_half_avg
    FROM trips
    WHERE trip_date BETWEEN '2023-01-01' AND '2023-06-30'
    GROUP BY driver_id
),
second AS (
    SELECT 
        driver_id,
        SUM(distance_km/fuel_consumed)/COUNT(driver_id) AS second_half_avg
    FROM trips
    WHERE trip_date BETWEEN '2023-07-01' AND '2023-12-31' 
    GROUP BY driver_id
)
SELECT 
    f.driver_id,
    d.driver_name,
    ROUND(f.first_half_avg, 2) AS first_half_avg,
    ROUND(s.second_half_avg, 2) AS second_half_avg,
    ROUND(s.second_half_avg - f.first_half_avg, 2) AS efficiency_improvement
FROM first f
INNER JOIN 
    drivers d ON f.driver_id = d.driver_id
INNER JOIN 
    second s ON f.driver_id = s.driver_id
WHERE 
    s.second_half_avg > f.first_half_avg
ORDER BY 
    efficiency_improvement DESC,
    driver_name ASC

#-------------------------------------------------------------------------------------------

# Subquery
SELECT 
    f.driver_id,
    d.driver_name,
    ROUND(f.first_half_avg, 2) AS first_half_avg,
    ROUND(s.second_half_avg, 2) AS second_half_avg,
    ROUND(s.second_half_avg - f.first_half_avg, 2) AS efficiency_improvement
FROM 
    (
        SELECT 
            driver_id,
            SUM(distance_km / fuel_consumed) / COUNT(driver_id) AS first_half_avg
        FROM trips
        WHERE trip_date BETWEEN '2023-01-01' AND '2023-06-30'
        GROUP BY driver_id
    ) f
JOIN 
    (
        SELECT 
            driver_id,
            SUM(distance_km / fuel_consumed) / COUNT(driver_id) AS second_half_avg
        FROM trips
        WHERE trip_date BETWEEN '2023-07-01' AND '2023-12-31'
        GROUP BY driver_id
    ) s ON f.driver_id = s.driver_id
JOIN 
    drivers d ON f.driver_id = d.driver_id
WHERE 
    s.second_half_avg > f.first_half_avg
ORDER BY 
    efficiency_improvement DESC,
    driver_name ASC;
