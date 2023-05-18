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


-- 4. Truncate Table Minions


-- 5. Drop All Tables