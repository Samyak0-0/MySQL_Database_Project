-- INNER JOIN - Show employees with their department names
SELECT e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- LEFT JOIN - Show all employees even if they don't have a department
SELECT e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- JOIN with three tables - employees, departments, and jobs
SELECT e.first_name, e.last_name, j.job_title, d.department_name, e.salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id;

-- Self JOIN - Show employees with their managers
SELECT emp.first_name + ' ' + emp.last_name as Employee,
       mgr.first_name + ' ' + mgr.last_name as Manager
FROM employees emp
LEFT JOIN employees mgr ON emp.manager_id = mgr.emp_id;

-- RIGHT JOIN - Show all departments even if they have no employees
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;