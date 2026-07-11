-- Problem number is 262 - Hard
-- https://leetcode.com/problems/trips-and-users/description/

-- Write your PostgreSQL query statement below
SELECT 
    t.request_at AS "Day",
    ROUND(COUNT(t.client_id) FILTER(WHERE status != 'completed')/
    COUNT(t.client_id)::DECIMAL, 2) AS "Cancellation Rate"
FROM Trips t
LEFT JOIN Users u ON t.client_id = u.users_id
LEFT JOIN Users u1 ON t.driver_id = u1.users_id
WHERE 
    u.banned = 'No' AND u1.banned = 'No'
    AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at
