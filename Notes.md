---------------------------------- DATABASES -----------------------------
-- CREATE DATABASE myDB;
-- DROP DATABASE myDB;
-- ALTER DATABASE myDB READ ONLY = 0;
-- USE myDB

----------------------------------- TABLES -------------------------------
-- CREATE TABLE employees (
-- 	employee_id INT,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     hourly_pay DECIMAL(5, 2),
--     hire_date DATE
-- );

-- SELECT * FROM employees;
-- RENAME TABLE employees TO workers;
-- DROP TABLE employees;

-- ALTER TABLE employees
-- ADD phone_number VARCHAR(15);

-- ALTER TABLE employees
-- RENAME COLUMN phone_number TO email;

-- ALTER TABLE employees
-- MODIFY COLUMN email VARCHAR(100);

-- ALTER TABLE employees
-- MODIFY email VARCHAR(100)
-- AFTER last_name; || FIRST;

-- ALTER TABLE employees
-- DROP COLUMN email;

------------------------------------ INSERT ROWS ----------------------------
-- INSERT INTO employees
-- VALUES(1, "Eugene", "Krabs", "krab@abv.bg", 25.50, "2023-01-02"); ||
-- VALUES	(2, "Hristo", "Yonkov", "ico@abv.bg", 100.00, "2023-01-03"),
-- 		(3, "Peter", "Petrov", "peter@abv.bg", 22.22, "2023-01-04"), 
--         (4, "Pavel", "Dimitrov", "pavel@abv.bg", 23.33, "2023-01-05"),
--         (5, "Strahil", "Strashnikov", "strahil@abv.bg", 22.10, "2023-01-06");

-- INSERT INTO employees (employee_id, first_name, last_name)
-- VALUES (6, "Meter", "Metrov");

------------------------------------- SELECT ---------------------------------
-- SELECT first_name, last_name FROM employees;
-- SELECT * FROM employees WHERE employee_id = 1; || first_name = "Pavel"; || hourly_pay >= 50; || hire_date <= "2023-01-04"; || employee_id != 1;
-- SELECT * FROM employees WHERE hire_date IS NULL; || hire_date IS NOT NULL;
-- SELECT first_name FROM employees WHERE hire_date IS NULL;

--------------------------------- Update & Delete ----------------------------
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE employees SET hourly_pay = 10.50, hire_date = "2023-01-07", email = "meter@abv.bg" WHERE employee_id = 6;
-- UPDATE employees SET hire_date = NULL WHERE employee_id = 6;
-- UPDATE employees SET hourly_pay = 10.25; // Update entire column!
-- DELETE FROM employees // Delete all rows!
-- DELETE FROM employees WHERE employee_id = 6;
-- SELECT * FROM employees;

-------------------------- Auto Commit, Commit, Rollback ---------------------
// Default on. Manually create savepoint when we need!
-- SET AUTOCOMMIT = OFF;

// Creating a safepoint.
-- COMMIT;

// Load last savepoint.
-- ROLLBACK;
-- DELETE FROM employeescoppy;
-- SELECT * FROM employeescoppy;

------------------------- CURRENT_DATE() && CURRENT_TIME() -------------------
-- CREATE TABLE test(
-- 	   my_date DATE,
--     my_time TIME,
--     my_datetime DATETIME
-- );
-- INSERT INTO test
-- VALUES(CURRENT_DATE() + 1, CURRENT_TIME(), NOW());
-- SELECT * FROM test;

----------------------------------- UNIQUE Constraint ------------------------
-- CREATE TABLE products(
-- 		product_id INT,
-- 		product_name VARCHAR(25) UNIQUE, // - You can add constraint when creating table, or later!
--      product_price DECIMAL(4, 2)
-- );

-- ALTER TABLE products
-- ADD CONSTRAINT
-- UNIQUE(product_name); // - Add constraint later.

-- INSERT INTO products
-- VALUES  (100, "Pizza", 12.50),
-- 		(101, "Juice", 2.00), 
-- 		(102, "Ice Cream", 4.50);
-- SELECT * FROM products;

-------------------------------------- NOT NULL Constraint -------------------------------
-- CREATE TABLE products(
-- 		product_id INT,
-- 		product_name VARCHAR(25),
--      product_price DECIMAL(4, 2) NOT NULL // - Add it when creating a table.
-- );

-- ALTER TABLE products
-- MODIFY product_price DECIMAL(4, 2) NOT NULL; // - Or add it later.

-- INSERT INTO products
-- VALUES(103, "Mocolate", NULL); // - This will not create the row you can add 0 value.
-- SELECT * FROM products;

-------------------------------------- CHECK Constraint -----------------------------------
// - Add a check when create table.
-- CREATE TABLE employees (
-- 	employee_id INT,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     hourly_pay DECIMAL(5, 2),
--     hire_date DATE,
-- 	   CONSTRAINT chk_hourly_pay CHECK (hourly_pay  >= 10.00)
-- );

// - Insert CHECK constraint later in the table.
-- ALTER TABLE employees
-- ADD CONSTRAINT chk_hourlt_pay CHECK (hourly_pay  >= 10.00);

// This will throw check error.
-- INSERT INTO employees
-- VALUES (6, "Sheldon", "Plankton", "asda@abv.bg", 5.00, "2023-01-07");

// This will drop the check constraint!
-- ALTER TABLE employees
-- DROP CHECK chk_hourly_pay;