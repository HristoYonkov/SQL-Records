-- 01. Select Employee Information
SELECT  id,
CONCAT(first_name, ' ', last_name) AS full_name,
job_title,
salary
FROM employees ORDER BY id;

-- 02. Select Employees with Filter
