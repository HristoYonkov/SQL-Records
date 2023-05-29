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
