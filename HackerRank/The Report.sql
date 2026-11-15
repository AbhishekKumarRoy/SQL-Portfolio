-- The Report - Medium
-- https://www.hackerrank.com/challenges/the-report/problem

SELECT 
    CASE
        WHEN g.Grade > 7 
        THEN s.Name 
        ELSE NULL
    END AS Name,
    g.Grade,
    s.Marks
FROM Students s
INNER JOIN 
    Grades g ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark 
ORDER BY 
    Grade DESC,
    Name ASC,
    Marks ASC
