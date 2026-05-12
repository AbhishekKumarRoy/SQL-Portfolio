-- Sourced from JPMorgan - Medium
-- https://datalemur.com/questions/card-launch-success

WITH cte AS (
  SELECT 
    card_name,
    issue_year,
    issue_month,
    issued_amount,
    ROW_NUMBER() OVER(
      PARTITION BY card_name
      ORDER BY issue_year ASC
    ) AS rnk_year,
    ROW_NUMBER() OVER(
      PARTITION BY card_name, issue_year
      ORDER BY issue_month ASC
    ) AS rnk_month    
  FROM monthly_cards_issued
)

SELECT 
  card_name,
  issued_amount
FROM cte
WHERE rnk_year = 1 AND rnk_month = 1
ORDER BY issued_amount DESC
