# The problem number is 3657 - Medium
# https://leetcode.com/problems/find-loyal-customers/description/

# Write your MySQL query statement below
WITH purchase AS (
    SELECT customer_id
    FROM customer_transactions
    WHERE transaction_type = 'purchase'
    GROUP BY customer_id
    HAVING COUNT(transaction_id) >= 3
),
active AS (
    SELECT customer_id
    FROM customer_transactions
    GROUP BY customer_id
    HAVING DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30
),
refund AS (
    SELECT customer_id
    FROM customer_transactions
    GROUP BY customer_id
    HAVING 
        SUM(IF(transaction_type = 'refund', 1, 0))*100/COUNT(transaction_id) < 20
)
SELECT p.customer_id
FROM purchase p
INNER JOIN active a ON p.customer_id = a.customer_id
INNER JOIN refund r ON a.customer_id = r.customer_id
ORDER BY p.customer_id ASC;
