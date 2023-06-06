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

-- 11. Movie awards
SELECT 
CONCAT(first_name, ' ', last_name) AS full_name,
CONCAT(REVERSE(last_name), '@cast.com') AS email,
birthdate AS age,
height
FROM actors;