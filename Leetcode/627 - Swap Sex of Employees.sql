-- Problem number is 627 - Easy
-- https://leetcode.com/problems/swap-sex-of-employees/description/

-- Write your PostgreSQL query statement below
UPDATE Salary
SET sex = (
    CASE
        WHEN sex = 'm'
        THEN 'f' ELSE 'm'
    END
)
