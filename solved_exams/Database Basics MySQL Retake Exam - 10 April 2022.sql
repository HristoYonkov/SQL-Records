-- 01. Table Design
CREATE TABLE countries (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL UNIQUE,
    continent VARCHAR(30) NOT NULL,
    currency VARCHAR(5) NOT NULL
);

CREATE TABLE genres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE actors (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    height INT,
    awards INT,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (id)
);

CREATE TABLE movies_additional_info (
	id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(10, 2) NOT NULL,
    runtime INT NOT NULL,
    picture_url VARCHAR(80) NOT NULL,
    budget DECIMAL(10, 2) NOT NULL,
    release_date DATE NOT NULL,
	has_subtitles TINYINT(1),
    description TEXT
);

CREATE TABLE movies (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(70) NOT NULL UNIQUE,
    country_id INT NOT NULL,
    movie_info_id INT NOT NULL UNIQUE,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (movie_info_id) REFERENCES movies_additional_info (id)
);

CREATE TABLE movies_actors (
	movie_id INT,
    actor_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (actor_id) REFERENCES actors (id)
);

CREATE TABLE genres_movies (
	genre_id INT,
	movie_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres (id),
    FOREIGN KEY (movie_id) REFERENCES movies (id)
);

-- 02. Insert
INSERT INTO actors (first_name, last_name, birthdate, height, awards, country_id) (
SELECT REVERSE(first_name) AS first_name,
REVERSE(last_name) AS last_name,
DATE_SUB(birthdate, INTERVAL 2 DAY) AS birthdate,
height + 10 AS height,
country_id AS awards,
(SELECT id FROM countries WHERE name = 'Armenia') AS country_id 
FROM actors WHERE id <= 10
);

-- 03. Update
UPDATE movies_additional_info 
SET runtime = runtime - 10
WHERE id BETWEEN 15 AND 25;

-- 04. Delete
DELETE FROM countries
WHERE id NOT IN (SELECT country_id FROM movies);

-- 05. Counties
SELECT 
id,
name,
continent,
currency
FROM countries
ORDER BY currency DESC, id;

-- 06. Old movies
SELECT 
m.id AS id,
m.title AS title,
runtime,
budget,
release_date
FROM movies_additional_info AS mai
JOIN movies AS m ON m.movie_info_id = mai.id
WHERE release_date BETWEEN '1996-01-01' AND '1999-12-31'
ORDER BY runtime, m.id LIMIT 20;

-- 07. Movie casting
SELECT 
CONCAT(first_name, ' ', last_name) AS full_name,
CONCAT(REVERSE(last_name), CHAR_LENGTH(last_name), '@cast.com') AS email,
2022 - SUBSTRING(birthdate, 1, 4) AS age,
height
FROM actors AS
WHERE id NOT IN (SELECT actor_id FROM movies_actors)
ORDER BY height;

-- 08. International festival
SELECT name, COUNT(m.title) AS movies_count FROM countries AS c
JOIN movies AS m ON m.country_id = c.id
GROUP BY name
HAVING movies_count >= 7
ORDER BY name DESC;

-- 09. Rating system
SELECT m.title,
(
	IF (mai.rating <= 4, 'poor',
		IF (mai.rating > 4 AND mai.rating <= 7, 'good', 'excellent')
    )
) AS rating,
(
	IF (mai.has_subtitles = 1, 'english', '-')
) AS subtitles,
mai.budget
FROM movies AS m
JOIN movies_additional_info AS mai ON mai.id = m.movie_info_id
ORDER BY mai.budget DESC;

-- 10. History movies
CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE ind INT;
	SET ind := LOCATE(' ', full_name);
RETURN (
	SELECT COUNT(g.name)
	FROM actors AS a
	JOIN movies_actors AS ma ON ma.actor_id = a.id
	JOIN movies AS m ON m.id = ma.movie_id
	JOIN genres_movies AS gm ON gm.movie_id = m.id
	JOIN genres AS g ON g.id = gm.genre_id
	WHERE a.first_name = SUBSTRING(full_name, 1, ind - 1)
    AND a.last_name = SUBSTRING(full_name, ind + 1)
    AND g.name = 'History'
    );
END

-- 11. Movie awards
CREATE PROCEDURE udp_award_movie(movie_title VARCHAR(50))
BEGIN
	UPDATE actors AS a
    JOIN movies_actors AS ma ON ma.actor_id = a.id
	JOIN movies AS m ON ma.movie_id = m.id
    SET a.awards = a.awards + 1
WHERE m.title = movie_title;
END