-- Average Population of Each Continent - Easy
-- https://www.hackerrank.com/challenges/average-population-of-each-continent/problem

SELECT 
    co.CONTINENT,
    FLOOR(AVG(c.POPULATION))
FROM COUNTRY co
INNER JOIN CITY c ON co.CODE = c.COUNTRYCODE
GROUP BY co.CONTINENT
