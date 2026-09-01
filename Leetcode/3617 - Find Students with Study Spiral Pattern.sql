-- Problem number is 3617 - Hard
-- https://leetcode.com/problems/find-students-with-study-spiral-pattern/description/

-- Write your PostgreSQL query statement below (Used Claude as the Testcases are wrong at the moment)

WITH ordered AS (
    -- gap (in days) since the previous session for each student
    SELECT
        student_id,
        subject,
        session_date,
        hours_studied,
        session_date - LAG(session_date) OVER (
            PARTITION BY student_id ORDER BY session_date
        ) AS gap
    FROM study_sessions
),
islands AS (
    -- start a new "island" whenever the gap is missing (first session)
    -- or is more than 1 day (i.e. sessions must fall on back-to-back
    -- calendar dates to count as part of the same consecutive run)
    SELECT
        student_id,
        subject,
        session_date,
        hours_studied,
        SUM(CASE WHEN gap IS NULL OR gap > 1 THEN 1 ELSE 0 END) OVER (
            PARTITION BY student_id ORDER BY session_date
        ) AS island_id
    FROM ordered
),
island_seq AS (
    -- position of each session within its own island
    SELECT
        student_id,
        island_id,
        session_date,
        subject,
        hours_studied,
        ROW_NUMBER() OVER (
            PARTITION BY student_id, island_id ORDER BY session_date
        ) AS pos
    FROM islands
),
island_stats AS (
    SELECT
        student_id,
        island_id,
        COUNT(*)                AS n_sessions,
        COUNT(DISTINCT subject) AS n_subjects,
        SUM(hours_studied)      AS total_hours
    FROM island_seq
    GROUP BY student_id, island_id
),
periodicity AS (
    -- for every position beyond the first cycle, the subject must match
    -- the subject exactly n_subjects positions earlier
    SELECT
        a.student_id,
        a.island_id,
        COUNT(*) AS checked,
        COUNT(*) FILTER (WHERE a.subject = b.subject) AS matched
    FROM island_seq a
    JOIN island_stats s
        ON a.student_id = s.student_id AND a.island_id = s.island_id
    JOIN island_seq b
        ON a.student_id = b.student_id
        AND a.island_id = b.island_id
        AND b.pos = a.pos - s.n_subjects
    WHERE a.pos > s.n_subjects
    GROUP BY a.student_id, a.island_id
),
qualifying_islands AS (
    SELECT
        s.student_id,
        s.island_id,
        s.n_subjects  AS cycle_length,
        s.total_hours AS total_study_hours
    FROM island_stats s
    JOIN periodicity p
        ON s.student_id = p.student_id AND s.island_id = p.island_id
    WHERE s.n_subjects >= 3                     -- at least 3 distinct subjects
      AND s.n_sessions >= 2 * s.n_subjects       -- at least 2 full cycles
      AND s.n_sessions % s.n_subjects = 0        -- whole number of cycles
      AND p.checked = p.matched                  -- every position matches its cycle predecessor
),
best_per_student AS (
    -- if a student somehow has multiple qualifying islands, keep the best one
    SELECT DISTINCT ON (student_id)
        student_id,
        cycle_length,
        total_study_hours
    FROM qualifying_islands
    ORDER BY student_id, cycle_length DESC, total_study_hours DESC
)
SELECT
    st.student_id,
    st.student_name,
    st.major,
    b.cycle_length,
    b.total_study_hours
FROM best_per_student b
JOIN students st ON st.student_id = b.student_id
ORDER BY b.cycle_length DESC, b.total_study_hours DESC;
