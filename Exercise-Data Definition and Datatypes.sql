-- 1. Create Tables
CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);

CREATE TABLE towns (
    town_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- 2. Alter Minions Table
ALTER TABLE towns
RENAME COLUMN town_id TO id;
----------------------------
ALTER TABLE minions
ADD COLUMN town_id INT,
ADD CONSTRAINT fk_minions_towns FOREIGN KEY minions(town_id)
REFERENCES towns(id);

-- 3. Insert Records in Both Tables
INSERT INTO towns (id, name)
VALUES(1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');

INSERT INTO minions (id, name, age, town_id)
VALUES(1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', NULL, 2);

-- 4. Truncate Table Minions
TRUNCATE TABLE minions;

-- 5. Drop All Tables
DROP TABLE minions;
DROP TABLE towns;

-- 6. Create Table People
CREATE TABLE people (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(5, 2),
    weight DOUBLE(5, 2),
    gender VARCHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

INSERT INTO people (name, gender, birthdate)
VALUES ('Hristo', 'm', DATE(NOW())),
('Ani', 'f', DATE(NOW())),
('Stoqn', 'm', DATE(NOW())),
('Pavel', 'm', DATE(NOW())),
('Emiliq', 'f', DATE(NOW()));

-- 7. Create Table Users
CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

INSERT INTO users (username, password)
VALUES ('Ico', '123123123'),
('Pavel', '123123'),
('Meter', '123123'),
('Hasan', '123123'),
('Kakasho', '123123');

-- 8. Change Primary Key
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY users(id, username);

-- 9. Set Default Value of a Field
ALTER TABLE users
CHANGE COLUMN last_login_time
last_login_time DATETIME DEFAULT NOW();

-- 10. Set Unique Field
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id),
CHANGE COLUMN username
username VARCHAR(30) UNIQUE;

-- 11. Movies Database
CREATE DATABASE movies;
USE movies;

CREATE TABLE directors (
	id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT
);
INSERT INTO directors (director_name, notes)
VALUES ('Pavel', 'Dobyr v bqganeto.'),
('Pavel', 'Dobyr v bqganeto.'),
('Pavel', 'Dobyr v bqganeto.'),
('Pavel', 'Dobyr v bqganeto.'),
('Pavel', 'Dobyr v bqganeto.');

CREATE TABLE genres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(20) NOT NULL,
    notes TEXT
);
INSERT INTO genres (genre_name, notes)
VALUES ('Actions', 'Actions are common genre.'),
('Actions', 'Actions are common genre.'),
('Actions', 'Actions are common genre.'),
('Actions', 'Actions are common genre.'),
('Actions', 'Actions are common genre.');

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(20) NOT NULL,
    notes TEXT
);
INSERT INTO categories (category_name, notes)
VALUES ('Igralen', 'Igralnite filmi sa za predpochitane'),
('Igralen', 'Igralnite filmi sa za predpochitane'),
('Igralen', 'Igralnite filmi sa za predpochitane'),
('Igralen', 'Igralnite filmi sa za predpochitane'),
('Igralen', 'Igralnite filmi sa za predpochitane');

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT,
    copyright_year YEAR,
    length DOUBLE(10 , 2 ),
    genre_id INT,
    category_id INT,
    rating DOUBLE(3 , 2 ),
    notes TEXT
);
INSERT INTO movies (title, director_id, genre_id, category_id)
VALUES ('Iron Man', 1, 2, 3),
('Iron Man', 1, 2, 5),
('Iron Man', 1, 2, 4),
('Iron Man', 1, 2, 3),
('Iron Man', 1, 2, 3);

-- 12. Car Rental Database
CREATE DATABASE car_rental;
USE car_rental;
CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    category NVARCHAR(50) NOT NULL, 
    daily_rate DECIMAL(5), 
    weekly_rate DECIMAL(5), 
    monthly_rate DECIMAL(5), 
    weekend_rate DECIMAL(5)
);
INSERT INTO categories(category)
VALUES ('Sedan'), ('Hatchback'), ('Coupe');

CREATE TABLE cars (
	id INT PRIMARY KEY AUTO_INCREMENT,
    plate_number NVARCHAR(10) NOT NULL UNIQUE,
    make NVARCHAR(30),
    model NVARCHAR(30),
    car_year INT,
    category_id INT,
    doors INT,
    picture BLOB,
    car_condition VARCHAR(30),
    available BOOLEAN,
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);
INSERT INTO cars(plate_number)
VALUES ('2314'), ('4321'), ('1234');

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
    notes TEXT
);
INSERT INTO employees (first_name, last_name)
VALUES ('Ivan', 'Ivanov'), ('Dimo', 'Petrov'), ('Pavel', 'Dimitrov');

CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
	driver_license_number INT NOT NULL,
	full_name VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    zip_code INT,
    notes TEXT
);
INSERT INTO customers(driver_license_number)
VALUES ('123312'), ('23112'), ('32312');

CREATE TABLE rental_orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOt NULL,
    customer_id INT NOT NULL,
    car_id INT,
    car_condition VARCHAR(50),
    tank_level INT,
	kilometrage_start INT,
    kilometrage_end INT,
    total_kilometrage INT,
    start_date DATE,
    end_date DATE,
	total_days INT,
	rate_applied INT,
	tax_rate INT,
    order_status VARCHAR(50),
    notes TEXT
);
INSERT INTO rental_orders(employee_id, customer_id)
VALUES (2, 3), (3, 2), (1, 1);

-- 13. Basic Insert
CREATE TABLE towns (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30)
);

CREATE TABLE addresses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    address_text VARCHAR(50),
    town_id INT,
    FOREIGN KEY (town_id)
    REFERENCES towns(id)
);

CREATE TABLE departments (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30)
);

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    middle_name VARCHAR(30),
    last_name VARCHAR(30),
    job_title VARCHAR(30),
    department_id INT,
    hire_date DATE,
    salary DOUBLE,
    address_id INT,
    FOREIGN KEY (department_id)
    REFERENCES departments(id),
    FOREIGN KEY (address_id)
    REFERENCES addresses(id)
);
--  Insert Into Judge this solution!
INSERT INTO towns (name)
VALUES ('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO departments (name)
VALUES ('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

-- 14. Basic Select All Fields
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

-- 15. Basic Select All Fields and Order Them
SELECT * FROM towns AS t ORDER BY t.name ASC;
SELECT * FROM departments AS d ORDER BY d.name ASC;
SELECT * FROM employees AS e ORDER BY e.salary DESC;

-- 16. Basic Select Some Fields
SELECT t.name FROM towns AS t ORDER BY t.name ASC;

SELECT  d.name FROM departments AS d ORDER BY d.name ASC;

SELECT e.first_name, e.last_name, e.job_title, e.salary
FROM employees AS e ORDER BY e.salary ASC;

-- 17. Increase Employees Salary
UPDATE employees
SET salary = salary * 1.1;
SELECT salary FROM employees;