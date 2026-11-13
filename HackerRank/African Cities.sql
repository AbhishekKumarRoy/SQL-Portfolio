-- African Cities - Easy
-- https://www.hackerrank.com/challenges/african-cities/problem

SELECT c.NAME
FROM CITY c
INNER JOIN COUNTRY co ON c.COUNTRYCODE = co.CODE
WHERE CONTINENT = 'Africa'
