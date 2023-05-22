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
