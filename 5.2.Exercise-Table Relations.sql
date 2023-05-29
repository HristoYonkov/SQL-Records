-- 1. One-To-One Relationship
CREATE TABLE people (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    passport_id INT NOT NULL UNIQUE
);
INSERT INTO people
VALUES (1, 'Roberto', 43300.00, 102), (2, 'Tom', 56100.00, 103), (3, 'Yana', 60200.00, 101);

CREATE TABLE passports (
	passport_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    passport_number VARCHAR(10) UNIQUE
);
INSERT INTO passports
VALUES (101, 'N34FG21B'), (102, 'K65LO4R7'), (103, 'ZE657QP2');

ALTER TABLE people
ADD FOREIGN KEY(passport_id) REFERENCES passports (passport_id);

-- 02. One-To-Many Relationship
CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    established_on DATE NOT NULL
);
INSERT INTO manufacturers
VALUES (1, 'BMW', '1916-03-01'), (2, 'Tesla', '2003-01-01'), (3, 'Lada', '1966-05-01');

CREATE TABLE models (
	model_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(20),
    manufacturer_id INT,
    FOREIGN KEY(manufacturer_id) REFERENCES manufacturers (manufacturer_id)
);
INSERT INTO models
VALUES (101, 'X1', 1), (102, 'i6', 1), (103, 'Model S', 2),
(104, 'Model X', 2), (105, 'Model 3', 2), (106, 'Nova', 3);