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