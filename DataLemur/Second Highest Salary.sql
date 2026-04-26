# Sourced from FAANG - Medium
# https://datalemur.com/questions/sql-second-highest-salary

WITH cte AS (
  SELECT 
    salary,
    DENSE_RANK() OVER(
      ORDER BY salary DESC
    ) AS rnk
  FROM employee
)
SELECT DISTINCT salary
FROM cte
WHERE rnk = 2
;
