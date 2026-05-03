-- Sourced from Google - Medium
-- https://datalemur.com/questions/odd-even-measurements

-- Using CASE
WITH cte AS (
  SELECT 
    measurement_time,
    measurement_value,
    ROW_NUMBER() OVER(
      PARTITION BY measurement_time::DATE
      ORDER BY measurement_time ASC
    ) AS rnk
  FROM measurements
)

SELECT 
  measurement_time::DATE,
  SUM(CASE
    WHEN rnk % 2 != 0
    THEN measurement_value ELSE 0
  END) AS odd_sum,
  SUM(CASE
    WHEN rnk % 2 = 0
    THEN measurement_value ELSE 0
  END) AS even_sum  
FROM cte
GROUP BY measurement_time::DATE
ORDER BY measurement_time::DATE ASC


-- Using FILTER
WITH cte AS (
  SELECT 
    measurement_time,
    measurement_value,
    ROW_NUMBER() OVER(
      PARTITION BY measurement_time::DATE
      ORDER BY measurement_time ASC
    ) AS rnk
  FROM measurements
)

SELECT 
  measurement_time::DATE,
  SUM(measurement_value) FILTER(WHERE rnk % 2 != 0) AS odd_sum,
  SUM(measurement_value) FILTER(WHERE rnk % 2 = 0) AS even_sum  
FROM cte
GROUP BY measurement_time::DATE
ORDER BY measurement_time::DATE ASC
