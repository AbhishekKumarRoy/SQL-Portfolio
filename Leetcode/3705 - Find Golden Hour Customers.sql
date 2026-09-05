-- Problem number is 3705 - Medium
-- https://leetcode.com/problems/find-golden-hour-customers/description/

-- Write your PostgreSQL query statement below
SELECT 
    customer_id,
    COUNT(customer_id) AS total_orders,
    ROUND(
        SUM(
            CASE
                WHEN (order_timestamp::TIME BETWEEN '11:00:00' AND '14:00:00'
                OR order_timestamp::TIME BETWEEN '18:00:00' AND '21:00:00')
                THEN 1 ELSE 0
            END
        )::DECIMAL/COUNT(customer_id)::DECIMAL * 100.00, 0
    ) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING 
    COUNT(customer_id) >= 3
    AND ROUND(AVG(order_rating), 2) >= 4.00
    AND ROUND(
            SUM(
                CASE
                    WHEN (order_timestamp::TIME BETWEEN '11:00:00' AND '14:00:00'
                    OR order_timestamp::TIME BETWEEN '18:00:00' AND '21:00:00')
                    THEN 1 ELSE 0
                END
            )::DECIMAL/COUNT(customer_id)::DECIMAL*100.00, 0
        ) >= 60.00
    AND SUM(
        CASE 
            WHEN order_rating IS NOT NULL 
            THEN 1 ELSE 0 
        END
    )::DECIMAL/COUNT(customer_id)::DECIMAL*100.00 >= 50
ORDER BY 
    average_rating DESC,
    customer_id DESC
