-- Sourced from UnitedHealth - Medium
-- https://datalemur.com/questions/uncategorized-calls-percentage

SELECT 
  ROUND(
    100.00*SUM(
      CASE 
        WHEN call_category IS NULL OR call_category = 'n/a'
        THEN 1 ELSE 0
      END
    )/COUNT(case_id), 1 -- Using case_id because for call_category, only non-null values will be counted
  ) AS uncategorised_call_pct 
FROM callers;
