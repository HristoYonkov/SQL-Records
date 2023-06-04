-- 01. Select Employee Information
SELECT  id,
CONCAT(first_name, ' ', last_name) AS full_name,
job_title,
salary
FROM employees ORDER BY id;

-- 02. Select Employees with Filter
SELECT  id,
CONCAT_WS(' ', first_name, last_name) AS full_name,
job_title,
salary
FROM employees WHERE salary > 1000;

-- 03. Update Salary and Select
SET SQL_SAFE_UPDATES = 0;
UPDATE employees
SET salary = salary + 100;
WHERE job_title = 'Manager';
    
SELECT salary FROM employees;

-- 04. Top Paid Employee
CREATE VIEW v_top_payd_employee AS
SELECT * from employees
ORDER BY salary DESC LIMIT 1;

SELECT * FROM v_top_payd_employee;

-- 05. Select Employees by Multiple Filters
SELECT * FROM employees AS e
WHERE e.department_id = 4 AND e.salary >= 1000;

-- 06. Delete from Table
DELETE FROM employees
WHERE department_id = 1
OR department_id = 2;
SELECT * FROM employees ORDER BY id;