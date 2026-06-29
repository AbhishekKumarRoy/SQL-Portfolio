-- Problem number is 175 - Easy
-- https://leetcode.com/problems/combine-two-tables/description/

-- Write your PostgreSQL query statement below
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId
