-- Population Census - Easy
-- https://www.hackerrank.com/challenges/asian-population/problem

SELECT SUM(c.POPULATION)
FROM CITY c
INNER JOIN COUNTRY co ON c.COUNTRYCODE = co.CODE
WHERE co.CONTINENT = 'Asia'
