-- 01. Find Names of All Employees by First Name
SELECT first_name, last_name FROM employees
WHERE LOWER(first_name) LIKE 'sa%'
ORDER BY employee_id;

-- 02. Find Names of All Employees by Last Name
SELECT first_name, last_name FROM employees
WHERE LOWER(last_name) LIKE '%ei%'
ORDER BY employee_id;

-- 03. Find First Names of All Employess
SELECT first_name FROM employees
WHERE department_id IN(3, 10) AND
YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

-- 04. Find All Employees Except Engineers
SELECT first_name, last_name FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

-- 05. Find Towns with Name Length
SELECT name FROM towns
WHERE CHAR_LENGTH(name) IN(5, 6)
ORDER BY name;

-- 06. Find Towns Starting With
SELECT town_id, name FROM towns
WHERE SUBSTRING(LOWER(name), 1, 1) IN('m', 'k', 'b', 'e')
ORDER BY name;

-- 07. Find Towns Not Starting With
SELECT * FROM towns
WHERE SUBSTRING(LOWER(name), 1, 1) NOT IN('r', 'b', 'd')
ORDER BY name;
-- second solution
SELECT * FROM towns
WHERE name REGEXP('^[^rRdRbB]')
ORDER BY name;

-- 08. Create View Employees Hired After
CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name FROM employees
WHERE YEAR(hire_date) > 2000;

-- 09. Length of Last Name
SELECT first_name, last_name FROM employees
WHERE CHAR_LENGTH(last_name) = 5;

-- 10. Countries Holding 'A'
SELECT country_name, iso_code FROM countries
WHERE (CHAR_LENGTH(country_name) -
CHAR_LENGTH(REPLACE(LOWER(country_name), 'a', ''))) >= 3
ORDER BY iso_code;
-- second solution
SELECT country_name, iso_code FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

-- 11. Mix of Peak and River Names
