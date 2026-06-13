-- Problem number is 1907 - Medium
-- https://leetcode.com/problems/count-salary-categories/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    'Low Salary' AS category,
    COUNT(account_id) AS accounts_count -- If the data is empty, the count will return 0.
FROM Accounts
WHERE income < 20000
UNION
SELECT 
    'Average Salary' AS category,
    COUNT(account_id) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000
UNION
SELECT 
    'High Salary' AS category,
    COUNT(account_id) AS accounts_count
FROM Accounts
WHERE income > 50000
