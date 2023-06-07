-- 01. Table Design
CREATE TABLE addresses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL
);

CREATE TABLE offices (
	id INT PRIMARY KEY AUTO_INCREMENT,
	workspace_capacity INT NOT NULL,
    website VARCHAR(50),
    address_id INT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES addresses (id)
);

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    job_title VARCHAR(20) NOT NULL,
    happiness_level CHAR(1) NOT NULL
);

CREATE TABLE teams (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(40) NOT NULL,
    office_id INT NOT NULL,
    leader_id INT NOT NULL UNIQUE,
    FOREIGN KEY (office_id) REFERENCES offices (id),
    FOREIGN KEY (leader_id) REFERENCES employees (id)
);

CREATE TABLE games (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    rating FLOAT DEFAULT(5.5) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    release_date DATE,
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES teams (id)
);

CREATE TABLE games_categories (
	game_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (game_id, category_id)
);

-- 02. Insert
INSERT INTO games (name, rating, budget, team_id) (
SELECT
REVERSE(LOWER(SUBSTRING(name, 2))) AS name,
id AS rating,
leader_id * 1000 AS budget,
id AS team_id
FROM teams
WHERE id BETWEEN 1 AND 9);

-- 03. Update
UPDATE employees AS e
JOIN teams AS t ON t.leader_id = e.id
SET salary = salary + 1000
WHERE e.age < 40 AND e.salary < 5000;

-- 04. Delete
DELETE FROM games
WHERE release_date IS NULL AND id NOT IN (SELECT game_id FROM games_categories);

-- 05. Employees
SELECT 
first_name,
last_name,
age,
salary,
happiness_level
FROM employees
ORDER BY salary, id;

-- 06. Addresses of the teams
SELECT 
t.name AS team_name,
a.name AS address_name,
CHAR_LENGTH(a.name) AS count_of_characters
FROM teams AS t
JOIN offices AS o ON o.id = t.office_id
JOIN addresses AS a ON a.id = o.address_id
WHERE o.website IS NOT NULL
ORDER BY team_name, address_name;

-- 07. Categories info
SELECT c.name, COUNT(g.id) AS games_count, ROUND(AVG(budget), 2) AS avg_budget, MAX(rating) AS max_rating
FROM categories AS c
JOIN games_categories AS gc ON gc.category_id = c.id
JOIN games AS g ON g.id = gc.game_id
GROUP BY c.name
HAVING max_rating >= 9.5
ORDER BY games_count DESC, c.name;

-- 08. Games of 2022
SELECT 
	g.name,
	release_date,
    CONCAT(SUBSTRING(description, 1, 10), '...') AS summary,
    IF(MONTH(release_date ) <= 3, 'Q1', 
    IF(MONTH(release_date ) <= 6, 'Q2',
		IF (MONTH(release_date ) <= 9, 'Q3', 'Q4')
		)
    ) AS `quarter`,
    t.name AS team_name
FROM games AS g
JOIN teams AS t on t.id = g.team_id
WHERE g.release_date IS NOT NULL
AND YEAR(g.release_date) = 2022
AND (MONTH(g.release_date) % 2) = 0 
AND SUBSTRING(REVERSE(g.name), 1, 1) = 2
ORDER BY `quarter`;

-- 09. Full info for games
SELECT 
	g.name,
	IF (budget < 50000, 'Normal budget', 'Insufficient budget') AS budget_level,
	t.name AS team_name,
	a.name AS address_name
FROM games AS g
JOIN teams AS t ON t.id = g.team_id
JOIN offices AS o ON o.id = t.office_id
JOIN addresses AS a ON a.id = o.address_id
WHERE g.release_date IS NULL AND g.id NOT IN (SELECT game_id FROM games_categories)
ORDER BY g.name;

-- 10. Find all basic information for the game
CREATE FUNCTION udf_game_info_by_name (game_name VARCHAR (20))
RETURNS TEXT
DETERMINISTIC
BEGIN
	RETURN(SELECT CONCAT_WS(' ','The',g.name,'is developed by a',
		t.name,'in an office with an address', a.name)
		FROM games AS g
		JOIN teams AS t ON t.id = g.team_id
		JOIN offices AS o ON o.id = t.office_id
		JOIN addresses AS a ON a.id = o.address_id
		WHERE g.name = game_name);
END

-- 11. Update budget of the games
