-- New Companies - Medium
-- https://www.hackerrank.com/challenges/the-company/problem

SELECT 
    c.company_code,
    c.founder,
    COUNT(DISTINCT l.lead_manager_code) AS total_lead_manager,
    COUNT(DISTINCT s.senior_manager_code) AS total_senior_manager,
    COUNT(DISTINCT m.manager_code) AS total_manager,
    COUNT(DISTINCT e.employee_code) AS total_employee
FROM Company c
LEFT JOIN Lead_Manager l ON c.company_code = l.company_code
LEFT JOIN Senior_Manager s ON l.lead_manager_code = s.lead_manager_code 
LEFT JOIN Manager m ON s.senior_manager_code = m.senior_manager_code
LEFT JOIN Employee e ON m.manager_code = e.manager_code 
GROUP BY 
    c.company_code,
    c.founder
ORDER BY c.company_code ASC
