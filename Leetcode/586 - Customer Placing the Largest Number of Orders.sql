-- Problem number is 586 - Easy
-- https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/

-- Write your PostgreSQL query statement below
SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(customer_number) DESC
LIMIT 1
