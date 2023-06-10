-- 01. Table Design
CREATE TABLE addresses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE categories(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL
);

CREATE TABLE clients(
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE drivers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    age INT,
    rating FLOAT DEFAULT 5.5
);

CREATE TABLE cars(
	id INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20),
    `year` INT DEFAULT 0 NOT NULL,
    mileage INT DEFAULT 0,
   `condition` CHAR(1) NOT NULL,
   category_id INT,
   FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE TABLE courses(
	id INT PRIMARY KEY AUTO_INCREMENT,
    from_address_id INT NOT NULL,
    `start` DATETIME NOT NULL,
    bill DECIMAL(10, 2) DEFAULT 10,
    car_id INT NOT NULL,
    client_id INT NOT NULL,
    FOREIGN KEY (car_id) REFERENCES cars (id),
    FOREIGN KEY (from_address_id) REFERENCES addresses (id),
    FOREIGN KEY (client_id) REFERENCES clients (id)
);

CREATE TABLE cars_drivers(
	car_id INT NOT NULL,
    driver_id INT NOT NULL,
    PRIMARY KEY (car_id, driver_id),
    FOREIGN KEY (car_id) REFERENCES cars (id),
    FOREIGN KEY (driver_id) REFERENCES drivers (id)
);

-- 02. Insert
INSERT INTO clients (full_name, phone_number) (
	SELECT CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT('(088) 9999', id * 2) AS phone_number
    FROM drivers
    WHERE id BETWEEN 10 AND 20
);

-- 03. Update
UPDATE cars
SET `condition` = 'C'
WHERE (mileage >= 800000 OR mileage IS NULL)
AND year <= 2010 AND make != 'Mercedes-Benz';

-- 04. Delete
DELETE FROM clients
WHERE CHAR_LENGTH(full_name) > 3 AND id NOT IN(SELECT client_id FROM courses);

-- 05. Cars
SELECT make, model, `condition`
FROM cars AS c
ORDER BY id;

-- 06. Drivers and Cars
SELECT
first_name, last_name, make, model, mileage
FROM drivers AS d
JOIN cars_drivers AS cd ON cd.driver_id = d.id
JOIN cars AS c ON c.id = cd.car_id
WHERE mileage IS NOT NULL
ORDER BY mileage DESC, first_name;

-- 07. Number of courses
SELECT c.id AS car_id,
c.make,
c.mileage,
COUNT(cour.car_id) AS count_of_courses,
ROUND(AVG(cour.bill), 2) AS avg_bill
FROM cars AS c
LEFT JOIN courses AS cour ON cour.car_id = c.id
GROUP BY c.id
HAVING count_of_courses != 2
ORDER BY count_of_courses DESC, car_id;

-- 08. Regular clients
SELECT cl.full_name,
COUNT(ca.id) AS count_of_cars,
SUM(cou.bill) AS total_sum
FROM clients AS cl
JOIN courses AS cou ON cou.client_id = cl.id
JOIN cars AS ca ON ca.id = cou.car_id
WHERE SUBSTRING(cl.full_name, 2, 1) = 'a'
GROUP BY cl.id
HAVING count_of_cars > 1
ORDER BY cl.full_name;

-- 09. Full info for courses
SELECT a.name AS name,
IF(HOUR(c.start) BETWEEN 6 AND 20, 'Day', 'Night') AS day_time,
c.bill,
cl.full_name,
ca.make,
ca.model,
cat.name AS category_name
FROM addresses AS a
JOIN courses AS c ON c.from_address_id = a.id
JOIN cars AS ca ON ca.id = c.car_id
JOIN categories AS cat ON cat.id = ca.category_id
JOIN clients AS cl ON cl.id = c.client_id
ORDER BY c.id;

-- 10. Find all courses by client’s phone number
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN(SELECT COUNT(c.phone_number) AS count
FROM clients AS c
JOIN courses AS cour ON cour.client_id = c.id
WHERE c.phone_number = phone_num);
END

-- 11. Full info for address
CREATE PROCEDURE udp_courses_by_address(address_name VARCHAR(100))
BEGIN
	SELECT 
a.name,
c.full_name,
IF(cour.bill <= 20, 'Low',
IF(cour.bill <= 30, 'Medium', 'High')) AS level_of_bill,
ca.make AS make,
ca.`condition`,
cat.name AS cat_name
FROM addresses AS a
JOIN courses AS cour ON cour.from_address_id = a.id
JOIN clients AS c ON c.id = cour.client_id
JOIN cars AS ca ON ca.id = cour.car_id
JOIN categories AS cat ON cat.id = ca.category_id
WHERE a.name = address_name
ORDER BY ca.make, c.full_name;
END