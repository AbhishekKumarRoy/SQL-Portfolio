-- Occupations - Medium
-- https://www.hackerrank.com/challenges/occupations/problem

-- Solution 1
SELECT 
    MIN(CASE WHEN Occupation='Doctor'    THEN Name END) AS Doctor,
    MIN(CASE WHEN Occupation='Professor' THEN Name END) AS Professor,
    MIN(CASE WHEN Occupation='Singer'    THEN Name END) AS Singer,
    MIN(CASE WHEN Occupation='Actor'     THEN Name END) AS Actor
FROM (
    SELECT Name, Occupation,
           ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) t
GROUP BY rn
ORDER BY rn;



-- Solution 2
SET @r1=0, @r2=0, @r3=0, @r4=0;
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM(
    SELECT 
        CASE 
            WHEN Occupation='Doctor' THEN (@r1:=@r1+1)
            WHEN Occupation='Professor' THEN (@r2:=@r2+1)
            WHEN Occupation='Singer' THEN (@r3:=@r3+1)
            WHEN Occupation='Actor' THEN (@r4:=@r4+1) 
        END AS RowNumber,
        CASE WHEN Occupation='Doctor' THEN Name end AS Doctor,
        CASE WHEN Occupation='Professor' THEN Name end AS Professor,
        CASE WHEN Occupation='Singer' THEN Name end AS Singer,
        CASE WHEN Occupation='Actor' THEN Name end AS Actor
    FROM OCCUPATIONS
    ORDER BY Name
    ) temp
GROUP BY RowNumber;
