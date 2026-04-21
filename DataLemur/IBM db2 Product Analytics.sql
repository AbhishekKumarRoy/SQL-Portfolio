# https://datalemur.com/questions/sql-ibm-db2-product-analytics

WITH cte AS (SELECT 
  e.employee_id,
  # Using COALESCE to get 0 for no query run by an employee
  COALESCE(COUNT(DISTINCT q.query_id), 0) AS unique_queries
FROM queries q
RIGHT JOIN employees e ON q.employee_id = e.employee_id
  # To get the third quarter of 2023, we will use the below in JOIN and not in WHERE because the condition used in JOIN will not remove the employees with no query.
  AND q.query_starttime::DATE BETWEEN '07/01/2023' AND '09/30/2023'
GROUP BY e.employee_id
)
SELECT 
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM cte
GROUP BY unique_queries
ORDER BY unique_queries
;
