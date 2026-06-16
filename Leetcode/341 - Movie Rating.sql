-- Problem number is 341 - Medium
-- https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50

-- Write your PostgreSQL query statement below
(
    SELECT u.name AS results
    FROM Users u
    INNER JOIN MovieRating mr ON u.user_id = mr.user_id
    GROUP BY u.name
    ORDER BY 
        COUNT(mr.rating) DESC,
        u.name ASC
    LIMIT 1
)
UNION ALL
(
    SELECT m.title AS results
    FROM Movies m
    INNER JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE 
        mr.created_at >= '2020-02-01'  -- Giving a range on date's because it's faster than EXTRACT/DATE_PART
        AND mr.created_at < '2020-03-01'
    GROUP BY m.title
    ORDER BY 
        AVG(mr.rating) DESC,
        m.title ASC
    LIMIT 1
)
