-- Problem number is 595
-- https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    name, 
    population,
    area
FROM World
WHERE area >= 3000000 OR population >= 25000000
