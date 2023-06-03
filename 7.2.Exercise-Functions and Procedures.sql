-- 01. Employees with Salary Above 35000
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
SELECT first_name, last_name FROM employees
WHERE salary > 35000
ORDER BY first_name, last_name, employee_id;
END

-- 02. Employees with Salary Above Number
CREATE PROCEDURE usp_get_employees_salary_above(min_number DECIMAL(19, 4))
BEGIN
SELECT first_name, last_name FROM employees
WHERE salary >= min_number
ORDER BY first_name, last_name, employee_id;
END

-- 03. Town Names Starting With
CREATE PROCEDURE usp_get_towns_starting_with(name_starts VARCHAR(50))
BEGIN
SELECT name FROM towns
WHERE name LIKE concat(name_starts, '%')
ORDER BY name;
END

-- 04. Employees from Town
CREATE PROCEDURE usp_get_employees_from_town(name_town VARCHAR(50))
BEGIN
SELECT e.first_name, e.last_name FROM employees AS e
JOIN addresses AS a ON e.address_id =  a.address_id
JOIN towns AS t ON a.town_id = t.town_id
WHERE t.name = name_town
ORDER BY e.first_name, e.last_name, e.employee_id;
END

-- 05. Salary Level Function
CREATE FUNCTION ufn_get_salary_level(`salary` DECIMAL(19, 4))
RETURNS VARCHAR(7)
DETERMINISTIC
BEGIN
    -- DECLARE result INT; -- Declaring variables in MySQL functions
	--     SET result := 10; -- Set value in MySQL Variables
	RETURN (
		CASE
			WHEN salary < 30000 THEN 'Low'
			WHEN salary <= 50000 THEN 'Average'
			ELSE 'High'
        END
    );
END

-- 06. Employees by Salary Level
CREATE FUNCTION ufn_get_salary_level(`salary` DECIMAL(19, 4))
RETURNS VARCHAR(7)
DETERMINISTIC
BEGIN
    -- DECLARE result INT; -- Declaring variables in MySQL functions
	--     SET result := 10; -- Set value in MySQL Variables
	RETURN (
		CASE
			WHEN salary < 30000 THEN 'Low'
			WHEN salary <= 50000 THEN 'Average'
			ELSE 'High'
        END
    );
END;
-- Actual solution below!
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE (SELECT ufn_get_salary_level(salary)) = salary_level
    OR (SELECT ufn_get_salary_level(salary)) = salary_level
    OR (SELECT ufn_get_salary_level(salary)) = salary_level
    ORDER BY first_name DESC, last_name DESC;
END

-- 07. Define Function


-- 08. Find Full Name


-- 9. People with Balance Higher Than


-- 10. Future Value Function


-- 11. Calculating Interest


-- 12. Deposit Money


-- 13. Withdraw Money


-- 14. Money Transfer


-- 15. Log Accounts Trigger


-- 16. Emails Trigger