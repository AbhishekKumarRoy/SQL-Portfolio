-- The PADS - Medium
-- https://www.hackerrank.com/challenges/the-pads/problem

SELECT 
    CONCAT(
        Name, '(', UPPER(LEFT(Occupation, 1)), ')'
    )
FROM OCCUPATIONS
ORDER BY 
    Name ASC,
    LEFT(Occupation, 1) ASC;

SELECT 
    CONCAT(
        'There are a total of ', COUNT(Occupation), ' ', LOWER(Occupation), 's.'
    )
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY 
    COUNT(Occupation) ASC,
    LOWER(Occupation) ASC;
