-- Define tables for the Employee database
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(8,2),
    commission_pct DECIMAL(2,2),
    manager_id INT,
    department_id INT
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    manager_id INT,
    location_id INT
);

CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(6,0),
    max_salary DECIMAL(6,0)
);

-- Add sample records:
INSERT INTO departments VALUES
(10, 'Admin', 200, 1700),
(20, 'Market', 201, 1800),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(80, 'Sales', 145, 2500),
(90, 'Executive', 100, 1700);

INSERT INTO jobs VALUES
('AD_PRES', 'President', 21000, 41000),
('AD_VP', 'Admin VP', 15500, 30500),
('IT_PROG', 'Developer', 4500, 10500),
('SA_MAN', 'Sales Manager', 10500, 20500),
('SA_REP', 'Sales Rep', 6500, 12500),
('ST_CLERK', 'Stock Clerk', 2500, 5500);

INSERT INTO employees VALUES
(100, 'Bone', 'King', 'SKING', '2003-06-17', 'AD_PRES', 24500, NULL, NULL, 90),
(101, 'Rock', 'Kochhar', 'NKOCHHAR', '2005-09-21', 'AD_VP', 17500, NULL, 100, 90),
(102, 'Lee', 'De Haan', 'LDEHAAN', '2001-01-13', 'AD_VP', 17200, NULL, 100, 90),
(103, 'Zoro', 'Hunold', 'AHUNOLD', '2006-01-03', 'IT_PROG', 9500, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '2007-05-21', 'IT_PROG', 6500, NULL, 103, 60),
(121, 'Wayne', 'Fripp', 'AFRIPP', '2005-04-10', 'ST_CLERK', 8300, NULL, 100, 50),
(145, 'John', 'Russell', 'JRUSSEL', '2004-10-01', 'SA_MAN', 14500, 0.4, 100, 80),
(146, 'Wick', 'Partners', 'KPARTNER', '2005-01-05', 'SA_REP', 13700, 0.3, 145, 80);


-- Practice SELECT queries:

-- 1. Retrieve all employee records
SELECT * FROM employees;

-- 2. Get employees with salary above 10000
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 10000;

-- 3. List employees ordered by salary (highest first)
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;

-- 4. Find employees whose first name starts with 'B'
SELECT first_name, last_name, email 
FROM employees 
WHERE first_name LIKE 'B%';

-- 5. Show employee count and salary statistics
SELECT COUNT(*) as employee_count,
       AVG(salary) as avg_salary,
       MAX(salary) as highest_salary,
       MIN(salary) as lowest_salary
FROM employees;

-- 6. Get employees with salary between 5000 and 15000
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary BETWEEN 5000 AND 15000;