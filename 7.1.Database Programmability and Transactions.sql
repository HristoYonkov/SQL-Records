-- Creating a Function in MySQL
-- Count employees by town!
DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(`town_name` VARCHAR(50))
RETURNS INT
DETERMINISTIC -- Is used when defining functions or procedures to indicate that the function always produces the same output for the same input parameters.
BEGIN
    DECLARE result INT; -- Declaring variables in MySQL functions
    SET result := 10; -- Set value in MySQL Variables
	RETURN (
		SELECT COUNT(*) FROM employees AS e
        JOIN addresses AS a ON a.address_id = e.address_id
        JOIN towns as t ON t.town_id = a.town_id
        WHERE t.`name` = `town_name`
    );
END $$

DELIMITER ;
;
-- 1. Count Employees by Tow-------------------------------------------------
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE e_count INT;
SET e_count := (SELECT COUNT(employee_id) FROM employees AS e
JOIN addresses AS a ON a.address_id = e.address_id
JOIN towns AS t ON t.town_id = a.town_id
WHERE t.name = town_name);
RETURN e_count;
END
-------------------------------------------------------------------------

-- Count how many employees in specific town!
SELECT ufn_count_employees_by_town('Redmond');
-- Count how many employees in each town!
SELECT name, ufn_count_employees_by_town(name) AS 'Employees Count' FROM towns;

SET @test := 10; -- Making a variable in the session, it is live until the server is shut down.
SELECT @test; -- Selecting a variable.

-------------------------------------------------------------------------------
-- Creating a Profedures in MySQL
DELIMITER $$
CREATE PROCEDURE usp_select_employees()
BEGIN
	SELECT * FROM employees;
END$$

DELIMITER ;
;

CALL usp_select_employees(); -- Calling a procedure!

-- ANOTHER EXAMPLE
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(percent DECIMAL(3,2),
OUT total_increase DECIMAL(19, 4))
BEGIN
	DECLARE local_increase DECIMAL(19, 4);

    SET local_increase := (SELECT ABS(SUM(salary) - SUM(salary) * percent)
	FROM employees);
    SET total_increase = local_increase;
    
    UPDATE employees SET salary = salary * percent;
END$$
DELIMITER ;
;
SELECT ABS(SUM(salary) - SUM(salary) * 1.10)
FROM employees;

SET @increase = 0;
CALL usp_raise_salaries(1.1, @increase);
SELECT @increase;

-- 2. Employees Promotion----------------------------------------------------------------
CREATE PROCEDURE usp_raise_salaries(department_name varchar(50))
BEGIN
UPDATE employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
SET salary = salary * 1.05
WHERE d.name = department_name;
END
-----------------------------------------------------------------------------------------
-- 3. Employees Promotion By ID
CREATE PROCEDURE usp_raise_salary_by_id(id int)
BEGIN
START TRANSACTION;
IF((SELECT count(employee_id) FROM employees WHERE employee_id
like id)<>1) THEN
ROLLBACK;
ELSE
UPDATE employees AS e SET salary = salary + salary*0.05
WHERE e.employee_id = id;
END IF;
END

-- 4. Triggered
CREATE TABLE deleted_employees(
employee_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(20),
middle_name VARCHAR(20),
job_title VARCHAR(50),
department_id INT,
salary DOUBLE
);

CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
INSERT INTO deleted_employees (first_name,last_name,
middle_name,job_title,department_id,salary)
VALUES(OLD.first_name,OLD.last_name,OLD.middle_name,
OLD.job_title,OLD.department_id,OLD.salary);
END;
