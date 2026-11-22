-- Placements - Medium
--https://www.hackerrank.com/challenges/placements/problem

SELECT s.name
FROM Students s
INNER JOIN Friends f ON s.ID = f.ID
INNER JOIN Packages p ON f.ID = p.ID
INNER JOIN Packages p1 ON f.Friend_ID = p1.ID
WHERE p1.Salary > p.Salary
ORDER BY p1.Salary
