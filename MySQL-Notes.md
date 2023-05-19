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
<!-- // Default on. Manually create savepoint when we need! -->
-- SET AUTOCOMMIT = OFF;

<!-- // Creating a safepoint. -->
-- COMMIT;

<!-- // Load last savepoint. -->
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
-- 		product_name VARCHAR(25) UNIQUE, <!-- You can add constraint when creating table, or later!
--      product_price DECIMAL(4, 2)
-- );

-- ALTER TABLE products
-- ADD CONSTRAINT
-- UNIQUE(product_name); <!-- Add constraint later.

-- INSERT INTO products
-- VALUES  (100, "Pizza", 12.50),
-- 		(101, "Juice", 2.00), 
-- 		(102, "Ice Cream", 4.50);
-- SELECT * FROM products;

-------------------------------------- NOT NULL Constraint -------------------------------
-- CREATE TABLE products(
-- 		product_id INT,
-- 		product_name VARCHAR(25),
--      product_price DECIMAL(4, 2) NOT NULL <!-- Add it when creating a table.
-- );

-- ALTER TABLE products
-- MODIFY product_price DECIMAL(4, 2) NOT NULL; <!-- Or add it later.

-- INSERT INTO products
-- VALUES(103, "Mocolate", NULL); <!-- This will not create the row you can add 0 value.
-- SELECT * FROM products;

-------------------------------------- CHECK Constraint -----------------------------------
<!-- // - Add a check constraint when create table. -->
-- CREATE TABLE employees (
-- 	employee_id INT,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     hourly_pay DECIMAL(5, 2),
--     hire_date DATE,
-- 	   CONSTRAINT chk_hourly_pay CHECK (hourly_pay  >= 10.00)
-- );

<!-- // - Insert CHECK constraint later in the table. -->
-- ALTER TABLE employees
-- ADD CONSTRAINT chk_hourlt_pay CHECK (hourly_pay  >= 10.00);

<!-- // This will throw check error. -->
-- INSERT INTO employees
-- VALUES (6, "Sheldon", "Plankton", "asda@abv.bg", 5.00, "2023-01-07");

<!-- // This will drop the check constraint! -->
-- ALTER TABLE employees
-- DROP CHECK chk_hourly_pay;

-------------------------------------- DEFAULT Constraint -------------------------------
<!-- // - Add a default constraint when create table. -->
-- CREATE TABLE products(
-- 		product_id INT,
-- 		product_name VARCHAR(25),
--      product_price DECIMAL(4, 2) NOT NULL DEFAULT 0.00
-- );

<!-- // - Add a DEFAULT constraint later in the table. -->
-- ALTER TABLE products
-- ALTER product_price SET DEFAULT 0.00;

-- INSERT INTO products (product_id, product_name)
-- VALUES  (104, "straw"),
-- 		   (105, "napkin");

-- SELECT * FROM products

-------------------------------------- PRIMARY KEY Constraint ---------------------------
<!-- // Commonly used as Unique identifier. The value can not be null and needs to be unique!
Adding a primary key when creating a table -->
-- CREATE TABLE transactions(
-- 	transaction_id INT PRIMARY KEY,
--  amount DECIMAL(5, 2)
-- );

<!-- // Adding a primary key to already existing tables. -->
-- ALTER TABLE transactions
-- ADD CONSTRAINT
-- PRIMARY KEY(transaction_id);

-- INSERT INTO transactions
-- VALUES(1001, 3.58);
-- SELECT * FROM transactions;

-------------------------------------- AUTO_INCREMENT Attribute ---------------------------
<!-- Can only be applied to column that has a key, and its uset to auto increment the column key.
Creating a primary key in table, by default is 1. -->
CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2)
);

-- INSERT INTO transactions (amount)
-- VALUES (3.99);

-- DELETE FROM transactions;

<!-- // Add different value for AUTO_INCREMENT. -->
-- ALTER TABLE transactions
-- AUTO_INCREMENT = 100;

<!-- // THis new value will start from 100! -->
-- INSERT INTO transactions (amount)
-- VALUES (0.99);
-- select * from transactions

----------------------------------- FOREIGN KEYS Constraint -----------------------------
<!-- Primary key from one table can be found into another table, using a foreign key
it establishes a link between two tables. Also prevent any actions wich will destroy the link
between tables. -->
-- CREATE TABLE customers (
-- 	customer_id INT PRIMARY KEY AUTO_INCREMENT,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50)
-- );

-- INSERT INTO customers (first_name, last_name)
-- VALUES  ("Pavel", "Dimitrov"),
-- 		("Hristo", "Yonkov"),
--         ("Peter", "Petrov");

<!-- Create table with foreign key constraint. -->
-- CREATE TABLE transactions (
-- 	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
--     amount DECIMAL(5, 2),
--     customer_id INT,
--     FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
-- );

<!-- Drops foreign key constraint from a table. -->
-- ALTER TABLE transactions
-- DROP FOREIGN KEY transactions_ibfk_1;

<!-- Changing and adding later a new name to foreign key into table. -->
-- ALTER TABLE transactions
-- ADD CONSTRAINT fk_customer_id
-- FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

<!-- Increase the number of foreign key. -->
-- ALTER TABLE transactions
-- AUTO_INCREMENT = 100;

-- INSERT INTO transactions (amount, customer_id)
-- VALUES  (3.99, 3),
-- 		(2.57, 2), 
--         (0.99, 1), 
--         (2.50, 3),
--         (1.60, 2);

<!-- You can`t delete when there is foreign key constraint -->
-- DELETE FROM customers WHERE customer_id = 3;

-- SELECT * FROM transactions

-------------------------------------- JOINS Clauses ------------------------------------
<!-- Joins are used to combine rows from two or more tables based on their related column
between them, such as FOREIGN KEY. They can be INER, LEFT and RIGHT joins. -->

<!-- Displays only mathed conditions. -->
-- SELECT * FROM transactions
-- INNER JOIN customers
-- ON transactions.customer_id = customers.customer_id;

<!-- Pick only columns that we need! -->
-- SELECT transaction_id, amount, first_name, last_name FROM 
-- transactions INNER JOIN customers
-- ON transactions.customer_id = customers.customer_id;

<!-- Example of RIGHT JOIN, same as left. Displays whole rows according to wich table are joined,
left or right. -->
-- SELECT * FROM 
-- transactions RIGHT JOIN customers
-- ON transactions.customer_id = customers.customer_id;

----------------------------------------- FUNCTIONS -------------------------------------
<!-- Calculate how many transactions are in the amount column. -->
-- SELECT COUNT(amount) AS "today's transactions"
-- FROM transactions;

<!-- Takes the maximum value in amount column. -->
-- SELECT MAX(amount) AS "Maximum transaction"
-- FROM transactions;

<!-- Takes the minimum value in amount column. -->
-- SELECT MIN(amount) AS "Minimum transaction"
-- FROM transactions;

<!-- Takes the average value in amount column. -->
-- SELECT AVG(amount) AS "Average transaction"
-- FROM transactions;

<!-- Sum all values in amount column. -->
-- SELECT SUM(amount) AS "Sum all transaction"
-- FROM transactions;

<!-- Concatenate two column values. -->
-- SELECT CONCAT(first_name, " ", last_name) AS full_name
-- FROM employees;

----------------------------- AND, OR, NOT, BETWEEN, IN Logical Operators ------------------------
-- SELECT * FROM employees
-- WHERE hire_date < "2023-05-07" AND job = "Senior Programmer";

-- SELECT * FROM employees
-- WHERE job = "Team Lead" OR job = "Senior Programmer";

-- SELECT * FROM employees
-- WHERE NOT job = "Team Lead" AND NOT job = "Senior Programmer";

-- SELECT * FROM employees
-- WHERE NOT job = "Team Lead";

-- SELECT * FROM employees
-- WHERE hire_date BETWEEN "2023-05-07" AND "2023-09-09";

-- SELECT * FROM employees
-- WHERE job IN ("Programmer", "Senior Programmer");

-------------------------------- %, _ Wild card characters --------------------------------
<!-- Used to subsitude (замести) one or more characters in a string.  -->
-- SELECT * FROM employees
-- WHERE first_name LIKE "P%";

-- SELECT * FROM employees
-- WHERE hire_date LIKE "2023%";

-- SELECT * FROM employees
-- WHERE first_name LIKE "%o";

-- SELECT * FROM employees
-- WHERE first_name LIKE "pe%";

<!-- Underscore (_), character represent 1 random letter. -->
-- SELECT * FROM employees
-- WHERE job LIKE "_rogrammer";

-- SELECT * FROM employees
-- WHERE job LIKE "_rogramme_";

-- SELECT * FROM employees
-- WHERE hire_date LIKE "____-05-__";

-- SELECT * FROM employees
-- WHERE hire_date LIKE "____-__-03";

<!-- We can combine them toghether! -->
-- SELECT * FROM employees
-- WHERE job LIKE "_r%";

----------------------------------- ORDER BY Clasuse -----------------------------------
<!-- ORDER BY clause sorts the results of a query in either ascending or descending order
based on wich column we list. -->
-- SELECT * FROM employees
-- ORDER BY first_name;

-- SELECT * FROM employees
-- ORDER BY first_name DESC;

-- SELECT * FROM employees
-- ORDER BY hire_date ASC;

-- SELECT * FROM transactions
-- ORDER BY amount ASC, customer_id DESC;

------------------------------------ LIMIT Clause ---------------------------------------
<!-- LIMIT clause is used to limit the number of records. -->
<!-- Usefull if you`re working with a lot of data. -->
<!-- Can be used to display large data on different pages (pagination). -->
-- SELECT * FROM customers
-- LIMIT 2;

-- SELECT * FROM customers
-- ORDER BY first_name LIMIT 2;

-- SELECT * FROM customers
-- ORDER BY first_name DESC LIMIT 2;

<!-- First number is the offset, second one is how many should table display. -->
-- SELECT * FROM customers
-- LIMIT 2, 1;

---------------------------------- UNION Operator ----------------------------------------
<!-- The UNION operator combines the result of two or more SELECT statements -->
<!-- It wont work if the two tables have a different amount of columns! -->
-- SELECT * FROM employees
-- UNION
-- SELECT * FROM customers

<!-- This will exclude duplicates! -->
-- SELECT first_name, last_name FROM employees
-- UNION
-- SELECT first_name, last_name FROM customers;

<!-- This will include duplicates! -->
-- SELECT first_name, last_name FROM employees
-- UNION ALL
-- SELECT first_name, last_name FROM customers;