-- Problem number is 601 - Hard
-- https://leetcode.com/problems/human-traffic-of-stadium/description/

-- Write your PostgreSQL query statement below
SELECT 
    s.id,
    s.visit_date,
    s.people
FROM Stadium s
JOIN 
    Stadium s1 ON s.id = s1.id + 1
JOIN 
    Stadium s2 ON s1.id = s2.id + 1
WHERE 
    s.people >= 100 AND s1.people >= 100 AND s2.people >= 100

UNION

SELECT 
    s1.id,
    s1.visit_date,
    s1.people
FROM Stadium s
JOIN 
    Stadium s1 ON s.id = s1.id + 1
JOIN 
    Stadium s2 ON s1.id = s2.id + 1
WHERE 
    s.people >= 100 AND s1.people >= 100 AND s2.people >= 100

UNION

SELECT 
    s2.id,
    s2.visit_date,
    s2.people
FROM Stadium s
JOIN 
    Stadium s1 ON s.id = s1.id + 1
JOIN 
    Stadium s2 ON s1.id = s2.id + 1
WHERE 
    s.people >= 100 AND s1.people >= 100 AND s2.people >= 100
ORDER BY id ASC
