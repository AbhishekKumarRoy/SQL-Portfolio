-- Problem number is 177 - Medium
-- https://leetcode.com/problems/nth-highest-salary/description/

CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
DECLARE
    n_offset INT := N - 1;
BEGIN
    -- Guard: return NULL if N is invalid
    IF N <= 0 THEN
        RETURN QUERY SELECT NULL::INT;
        RETURN;
    END IF;
    
    RETURN QUERY (
        SELECT DISTINCT e.salary
        FROM Employee e
        ORDER BY e.salary DESC
        LIMIT 1 OFFSET n_offset
    );
END;
$$ LANGUAGE plpgsql;
