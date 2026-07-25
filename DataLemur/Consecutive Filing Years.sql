-- Sourced from Intuit - Hard
-- https://datalemur.com/questions/consecutive-filing-years

SELECT DISTINCT(f.user_id)
FROM filed_taxes f
INNER JOIN filed_taxes f1 ON f.user_id = f1.user_id 
  AND DATE_PART('YEAR', f.filing_date) = DATE_PART('YEAR', f1.filing_date) + 1
INNER JOIN filed_taxes f2 ON f1.user_id = f2.user_id 
  AND DATE_PART('YEAR', f1.filing_date) = DATE_PART('YEAR', f2.filing_date) + 1
WHERE LOWER(f.product) LIKE 'turbotax%'
ORDER BY f.user_id ASC
