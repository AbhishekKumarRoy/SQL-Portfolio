-- Problem number is 3642 - Medium
-- https://leetcode.com/problems/find-books-with-polarized-opinions/

-- Write your PostgreSQL query statement below
SELECT 
    r.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    MAX(r.session_rating) - MIN(r.session_rating) AS rating_spread,
    ROUND(COUNT(r.session_rating) FILTER(
        WHERE r.session_rating <> 3
    )::DECIMAL/COUNT(r.session_rating)::DECIMAL, 2) AS polarization_score
FROM reading_sessions r
INNER JOIN books b ON r.book_id = b.book_id
GROUP BY 
    r.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages
HAVING
    COUNT(r.session_id) > 4 
    AND MAX(r.session_rating) > 3 
    AND MIN(r.session_rating) < 3
    AND ROUND(COUNT(r.session_rating) FILTER(
        WHERE session_rating <> 3
    )::DECIMAL/COUNT(session_rating)::DECIMAL, 2) >= 0.6
ORDER BY 
    polarization_score DESC,
    title DESC
