# Sourced from CVS Health - Easy
# https://datalemur.com/questions/top-profitable-drugs

# Solution 1 - Using CTE
WITH cte AS (
  SELECT 
    drug,
    ROUND(total_sales - cogs, 2) AS total_profit,
    RANK() OVER(ORDER BY total_sales-cogs DESC) AS rnk
  FROM pharmacy_sales
)
SELECT 
  drug,
  total_profit
FROM cte
WHERE rnk < 4
ORDER BY rnk ASC;


# Solution 2 - Using LIMIT
SELECT 
  drug,
  total_sales - cogs AS total_profit
FROM 
  pharmacy_sales
ORDER BY total_profit DESC
LIMIT 3
