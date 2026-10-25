-- Revising Aggregations - The Count Function - Easy
-- https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem

SELECT COUNT(DISTINCT NAME)
FROM CITY
WHERE POPULATION > 100000
