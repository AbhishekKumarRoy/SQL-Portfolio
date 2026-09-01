-- Problem number is 3617 - Hard
-- https://leetcode.com/problems/find-students-with-study-spiral-pattern/description/

-- Write your PostgreSQL query statement below (Used Claude as the Testcases are wrong at the moment)

WITH ordered AS (
    SELECT
        student_id,
        subject,
        session_date,
        hours_studied,
        session_date - LAG(session_date) OVER (
            PARTITION BY student_id ORDER BY session_date
        ) AS gap,
        ROW_NUMBER() OVER (
            PARTITION BY student_id ORDER BY session_date
        ) AS pos
    FROM study_sessions
),
student_gap_ok AS (
    -- a student only survives if NO gap anywhere in their full history
    -- exceeds 2 days; one bad gap disqualifies them completely, even if
    -- a perfectly valid 2-cycle spiral exists elsewhere in their data
    SELECT student_id
    FROM ordered
    GROUP BY student_id
    HAVING COALESCE(MAX(gap), 0) <= 2
),
student_stats AS (
    SELECT
        student_id,
        COUNT(*)                AS n_sessions,
        COUNT(DISTINCT subject) AS n_subjects,
        SUM(hours_studied)      AS total_hours
    FROM ordered
    GROUP BY student_id
),
periodicity AS (
    -- for every position beyond the first cycle, the subject must match
    -- the subject exactly n_subjects positions earlier
    SELECT
        a.student_id,
        COUNT(*) AS checked,
        COUNT(*) FILTER (WHERE a.subject = b.subject) AS matched
    FROM ordered a
    JOIN student_stats s ON a.student_id = s.student_id
    JOIN ordered b
        ON a.student_id = b.student_id
        AND b.pos = a.pos - s.n_subjects
    WHERE a.pos > s.n_subjects
    GROUP BY a.student_id
),
qualifying AS (
    SELECT
        s.student_id,
        s.n_subjects  AS cycle_length,
        s.total_hours AS total_study_hours
    FROM student_stats s
    JOIN student_gap_ok g ON g.student_id = s.student_id
    JOIN periodicity p ON p.student_id = s.student_id
    WHERE s.n_subjects >= 3                     -- at least 3 distinct subjects
      AND s.n_sessions >= 2 * s.n_subjects       -- at least 2 full cycles
      AND s.n_sessions % s.n_subjects = 0        -- whole number of cycles
      AND p.checked = p.matched                  -- every position matches its cycle predecessor
)
SELECT
    st.student_id,
    st.student_name,
    st.major,
    q.cycle_length,
    q.total_study_hours
FROM qualifying q
JOIN students st ON st.student_id = q.student_id
ORDER BY q.cycle_length DESC, q.total_study_hours DESC;
