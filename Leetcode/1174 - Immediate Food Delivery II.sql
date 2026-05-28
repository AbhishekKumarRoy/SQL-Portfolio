-- Problem number is 1174 - Medium
-- https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    ROUND(
        100.00 * COUNT(order_date) FILTER(
            WHERE order_date = customer_pref_delivery_date
        )/COUNT(order_date), 2
    ) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT 
        customer_id,
        MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
)
