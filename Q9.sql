-- GROUP BY with aggregate functions
SELECT department_id, COUNT(*) as emp_count, AVG(salary) as avg_salary
FROM employees
GROUP BY department_id;

-- GROUP BY with HAVING clause
SELECT department_id, COUNT(*) as emp_count, AVG(salary) as avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 8000;

-- GROUP BY with JOIN
SELECT d.department_name, COUNT(e.emp_id) as employee_count, 
       COALESCE(AVG(e.salary), 0) as avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY employee_count DESC;

-- GROUP BY with multiple columns
SELECT j.job_title, d.department_name, COUNT(*) as emp_count
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY j.job_title, d.department_name
ORDER BY emp_count DESC;