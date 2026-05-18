-- Problem number is 620 - Easy
-- https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
SELECT 
    id,
    movie,
    description,
    rating
FROM Cinema
WHERE (id % 2 <> 0) AND (description <> 'boring')
ORDER BY rating DESC
