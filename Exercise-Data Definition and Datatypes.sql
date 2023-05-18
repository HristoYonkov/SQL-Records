-- 1. Create Tables
CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);

CREATE TABLE towns (
    town_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
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


-- 5. Drop All Tables