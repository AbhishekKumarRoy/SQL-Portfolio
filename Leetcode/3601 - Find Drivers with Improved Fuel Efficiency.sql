-- Problem number is 3601 - Medium
-- https://leetcode.com/problems/find-drivers-with-improved-fuel-efficiency/description/

-- Solution 1 (Simple and easy to understand)
-- Write your PostgreSQL query statement below
WITH first_half AS (
    SELECT 
        trip_id,
        driver_id,
        trip_date,
        distance_km,
        fuel_consumed,
        distance_km/fuel_consumed AS fuel_efficiency
    FROM trips
    WHERE DATE_PART('MONTH', trip_date) BETWEEN '1' AND '6'
), 
second_half AS (
    SELECT 
        trip_id,
        driver_id,
        trip_date,
        distance_km,
        fuel_consumed,
        distance_km/fuel_consumed AS fuel_efficiency
    FROM trips
    WHERE DATE_PART('MONTH', trip_date) BETWEEN '7' AND '12'
)

SELECT 
    f.driver_id,
    d.driver_name,
    ROUND(AVG(f.fuel_efficiency), 2) AS first_half_avg,
    ROUND(AVG(s.fuel_efficiency), 2) AS second_half_avg,
    ROUND(
        AVG(s.fuel_efficiency) - AVG(f.fuel_efficiency), 2
    ) AS efficiency_improvement
FROM first_half f
INNER JOIN second_half s ON f.driver_id = s.driver_id
INNER JOIN drivers d ON f.driver_id = d.driver_id
GROUP BY 
    f.driver_id,
    d.driver_name
HAVING ROUND(
        AVG(s.fuel_efficiency) - AVG(f.fuel_efficiency), 2
    ) > 0
ORDER BY 
    efficiency_improvement DESC,
    driver_name ASC


-- Solution 2 (No CTE, Only Joins)
-- Write your PostgreSQL query statement below
SELECT 
    f.driver_id,
    d.driver_name,
    ROUND(AVG(f.distance_km/f.fuel_consumed), 2) AS first_half_avg,
    ROUND(AVG(s.distance_km/s.fuel_consumed), 2) AS second_half_avg,
    ROUND(
        AVG(s.distance_km/s.fuel_consumed) - 
        AVG(f.distance_km/f.fuel_consumed), 2
    ) AS efficiency_improvement
FROM trips f
INNER JOIN trips s ON f.driver_id = s.driver_id 
INNER JOIN drivers d ON f.driver_id = d.driver_id
    AND DATE_PART('MONTH', f.trip_date) BETWEEN 1 AND 6
    AND DATE_PART('MONTH', s.trip_date) BETWEEN 7 AND 12
GROUP BY 
    f.driver_id,
    d.driver_name
HAVING 
    ROUND(
        AVG(s.distance_km/s.fuel_consumed) - 
        AVG(f.distance_km/f.fuel_consumed), 2
    ) > 0
ORDER BY 
    efficiency_improvement DESC,
    driver_name ASC
