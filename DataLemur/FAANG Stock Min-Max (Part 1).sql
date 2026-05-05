-- Sourced from Bloomberg - Medium
-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

WITH highest AS (
  SELECT 
    ticker,
    TO_CHAR(date::DATE, 'Mon-YYYY') AS highest_mth,
    open AS highest_open,
    ROW_NUMBER() OVER(
      PARTITION BY ticker
      ORDER BY open DESC
    ) AS rnk_high
  FROM stock_prices
),
lowest AS (
  SELECT 
    ticker,
    TO_CHAR(date::DATE, 'Mon-YYYY') AS lowest_mth,
    open AS lowest_open,
    ROW_NUMBER() OVER(
      PARTITION BY ticker
      ORDER BY open ASC
    ) AS rnk_low
  FROM stock_prices
)

SELECT 
  h.ticker,
  h.highest_mth,
  h.highest_open,
  l.lowest_mth,
  l.lowest_open
FROM highest h
INNER JOIN lowest l ON h.ticker = l.ticker
WHERE h.rnk_high = 1 AND l.rnk_low = 1
;
