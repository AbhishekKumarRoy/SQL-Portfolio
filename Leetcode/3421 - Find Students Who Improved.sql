-- Problem number is 3421 - Medium
-- https://leetcode.com/problems/find-students-who-improved/

-- Write your PostgreSQL query statement below
WITH first AS (
    SELECT 
        student_id,
        subject,
        score AS first_score
    FROM Scores
    WHERE (student_id, subject, exam_date) IN (
        SELECT 
            student_id,
            subject,
            MIN(exam_date)
        FROM Scores
        GROUP BY 
            student_id,
            subject
    )
),
latest AS (
    SELECT 
        student_id,
        subject,
        score AS latest_score
    FROM Scores
    WHERE (student_id, subject, exam_date) IN (
        SELECT 
            student_id,
            subject,
            MAX(exam_date)
        FROM Scores
        GROUP BY 
            student_id,
            subject
    )
)

SELECT 
    l.student_id,
    l.subject,
    f.first_score,
    l.latest_score
FROM latest l
INNER JOIN first f ON 
    l.student_id = f.student_id AND l.subject = f.subject
WHERE f.first_score < l.latest_score
ORDER BY 
    student_id,
    subject

