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
    ORDER BY first_name DESC, last_name DESC;
END

-- 07. Define Function
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS INT
BEGIN
	RETURN word REGEXP (CONCAT('^[',set_of_letters,']+$'));
END

-- 08. Find Full Name
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM account_holders
	ORDER BY full_name, id;
END

-- 9. People with Balance Higher Than
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(balance_number INT)
BEGIN
	SELECT a.first_name, a.last_name FROM account_holders AS a
	JOIN accounts as acc ON a.id = acc.account_holder_id
	GROUP BY a.id
	HAVING SUM(acc.balance) > balance_number
	ORDER BY acc.account_holder_id;
END 

-- 10. Future Value Function
CREATE FUNCTION ufn_calculate_future_value(
    sum DECIMAL(19, 4),
    yearly_interest_rate DOUBLE,
    num_years INT
) RETURNS DECIMAL(19, 4)
BEGIN
	RETURN sum * POW((1 + yearly_interest_rate), num_years);  
END

-- 11. Calculating Interest
CREATE FUNCTION ufn_calculate_future_value(
    sum DECIMAL(19, 4),
    yearly_interest_rate DECIMAL(19, 4),
    num_years INT
) RETURNS DECIMAL(19, 4)
BEGIN
	RETURN sum * POW((1 + yearly_interest_rate), num_years);  
END;

CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_per_year DECIMAL(19, 4))
BEGIN
	SELECT 
    a.id AS account_id,
    ah.first_name,
    ah.last_name,
    a.balance AS current_balance,
    ufn_calculate_future_value(a.balance, interest_per_year, 5) AS balance_in_5_years
    FROM accounts AS a
	JOIN account_holders AS ah ON ah.id = a.account_holder_id
	WHERE a.id = account_id;
END

-- 12. Deposit Money
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	IF money_amount > 0
		AND (SELECT id FROM accounts WHERE id = account_id) IS NOT NULL
    THEN
		START TRANSACTION;
        UPDATE accounts
        SET balance = balance + money_amount
        WHERE id = account_id;
	END IF;
END

-- 13. Withdraw Money
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	IF money_amount > 0 THEN 
		START TRANSACTION;
			UPDATE accounts AS a
			SET a.balance = a.balance - money_amount
            WHERE account_id = a.id;
            
            IF (SELECT balance FROM accounts WHERE account_id = id) < 0 THEN
				ROLLBACK;
            ELSE 
				COMMIT;
			END IF;
    END IF;
END

-- 14. Money Transfer
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, money_amount DECIMAL(19, 4)) 
BEGIN
	IF money_amount > 0
		AND from_account_id <> to_account_id
		AND (SELECT id FROM accounts WHERE from_account_id = id) IS NOT NULL
		AND (SELECT id FROM accounts WHERE to_account_id = id) IS NOT NULL
        AND (SELECT balance FROM accounts WHERE from_account_id = id) >= money_amount
        THEN
			START TRANSACTION;
            
            UPDATE accounts SET
            balance = balance - money_amount
            WHERE id = from_account_id;
            
            UPDATE accounts SET
            balance = balance + money_amount
            WHERE id = to_account_id;
    END IF;
END

-- 15. Log Accounts Trigger
CREATE TABLE `logs`(
	log_id INT PRIMARY KEY AUTO_INCREMENT,
	account_id INT NOT NULL,
    old_sum DECIMAL(19, 4),
    new_sum DECIMAL(19, 4)
);

CREATE TRIGGER trigger_balance_update
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
	IF OLD.balance <> NEW.balance
    THEN
		INSERT INTO logs (account_id, old_sum, new_sum)
		VALUE(OLD.id, OLD.balance, NEW.balance);
    END IF;
END

-- 16. Emails Trigger
CREATE TABLE `logs`(
	log_id INT PRIMARY KEY AUTO_INCREMENT,
	account_id INT NOT NULL,
    old_sum DECIMAL(19, 4),
    new_sum DECIMAL(19, 4)
);

CREATE TRIGGER trigger_balance_update
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
	IF OLD.balance <> NEW.balance
    THEN
		INSERT INTO logs (account_id, old_sum, new_sum)
		VALUE(OLD.id, OLD.balance, NEW.balance);
    END IF;
END;
-- Actual solution
CREATE TABLE notification_emails(
	id INT PRIMARY KEY AUTO_INCREMENT,
	recipient INT NOT NULL,
	subject VARCHAR(100) NOT NULL,
    body TEXT NOT NULL
);

CREATE TRIGGER tr_notification_email_creation
AFTER INSERT ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails(recipient, subject, body)
    VALUES (
		NEW.account_id,
        CONCAT('Balance change for account: ', NEW.account_id),
        CONCAT_WS(' ',
			'On',
            DATE_FORMAT(NOW(), '%b %d %y at %r'),
            'your balance was changed from',
            NEW.old_sum,
            'to',
            NEW.new_sum));
END;