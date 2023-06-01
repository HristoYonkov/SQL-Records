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
END$$

DELIMITER ;
;

-- Count how many employees in specific town!
SELECT ufn_count_employees_by_town('Redmond');
-- Count how many employees in each town!
SELECT name, ufn_count_employees_by_town(name) AS 'Employees Count' FROM towns;

SET @test := 10; -- Making a variable in the session, it is live until the server is shut down.
SELECT @test; -- Selecting a variable.


-- Creating a Profedures in MySQL
DELIMITER $$
CREATE PROCEDURE usp_select_employees()
BEGIN
	SELECT * FROM employees;
END$$

DELIMITER ;
;

CALL usp_select_employees(); -- Calling a procedure!