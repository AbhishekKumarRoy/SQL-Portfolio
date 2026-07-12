-- Sourced from United Health - Hard
-- https://datalemur.com/questions/long-calls-growth

WITH long_calls AS (
  SELECT 
    DATE_PART('YEAR', call_date) AS yr,
    DATE_PART('MONTH', call_date) AS mth,
    COUNT(case_id) AS curr_mth_calls,
    LAG(COUNT(case_id)) OVER (
      ORDER BY DATE_PART('YEAR', call_date),
      DATE_PART('MONTH', call_date)
    ) AS prev_mth_calls
FROM callers
WHERE call_duration_secs > 300
GROUP BY 
  DATE_PART('YEAR', call_date),
  DATE_PART('MONTH', call_date)
)

SELECT
  yr,
  mth,
  ROUND(100.0 * 
    (curr_mth_calls - prev_mth_calls)/prev_mth_calls, 1
  ) AS long_calls_growth_pct
FROM long_calls
ORDER BY yr, mth;
