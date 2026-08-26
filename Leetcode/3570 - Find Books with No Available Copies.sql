-- Problem number is 3570 - Easy
-- https://leetcode.com/problems/find-books-with-no-available-copies/description/

-- Write your PostgreSQL query statement below
SELECT 
    l.book_id,
    l.title,
    l.author,
    l.genre,
    l.publication_year,
    COUNT(b.book_id) FILTER(
        WHERE b.return_date IS NULL
    ) AS current_borrowers
FROM library_books l
INNER JOIN borrowing_records b ON l.book_id = b.book_id
WHERE (l.book_id, l.total_copies) IN (
    SELECT 
        book_id,
        COUNT(book_id)
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
)
GROUP BY 
    l.book_id,
    l.title,
    l.author,
    l.genre,
    l.publication_year
ORDER BY 
    current_borrowers DESC,
    title ASC
