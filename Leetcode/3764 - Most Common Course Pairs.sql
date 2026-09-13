-- Problem number is 3764 - Hard
-- https://leetcode.com/problems/most-common-course-pairs/description/

-- Write your PostgreSQL query statement below
WITH top_performer AS (
    SELECT user_id
    FROM course_completions
    GROUP BY user_id
    HAVING 
        COUNT(course_id) > 4
        AND AVG(course_rating) >= 4
),
sequence AS (
    SELECT
        c.user_id,
        c.course_id,
        c.course_name AS first_course,
        LEAD(c.course_name) OVER(
            PARTITION BY c.user_id 
            ORDER BY c.completion_date ASC
        ) AS second_course
    FROM course_completions c
    INNER JOIN top_performer t ON c.user_id = t.user_id
)

SELECT
    first_course,
    second_course,
    COUNT(*) AS transition_count
FROM sequence
WHERE second_course IS NOT NULL
GROUP BY 
    first_course,
    second_course
ORDER BY 
    transition_count DESC,
-- Using LOWER to sort correctly (due to the comparison mechanism based on the binary value (ASCII Code) of each character)
    LOWER(first_course) ASC,
    LOWER(second_course) ASC
