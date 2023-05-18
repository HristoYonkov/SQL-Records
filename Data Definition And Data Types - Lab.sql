-- 01. Create Tables
CREATE TABLE employees (
	id INT primary key AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
	id INT primary key  AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
	id INT primary key  AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
	category_id VARCHAR(50) NOT NULL
);

-- 02. Insert Data in Tables
INSERT INTO employees
VALUES (1, "Stamat", "Stamatov"), (2, "Pavel", "Dimitrov"), (3, "Peter", "Petrov");

-- 03. Alter Tables
ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50) NOT NULL;

-- 04. Adding Constraints
ALTER TABLE products
ADD CONSTRAINT fk_categories_id 
FOREIGN KEY(category_id) REFERENCES categories(id);
