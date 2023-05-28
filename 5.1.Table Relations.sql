-- 1. Mountains and Peaks
CREATE table mountains (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
    -- CONSTRAINT pk_mountains_id PRIMARY KEY(id)
);

CREATE table peaks (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    mountain_id INT,
    CONSTRAINT fk_peaks_mountains_id
    FOREIGN KEY(mountain_id) REFERENCES mountains(id)
);

-- 2. Trip Organization
SELECT driver_id, vehicle_type,
CONCAT(first_name, ' ', last_name) AS driver_name
FROM vehicles AS v
JOIN campers AS c
ON v.driver_id = c.id;
-- My solution with compile time error
SELECT driver_id, vehicle_type,
(SELECT CONCAT(first_name, ' ', last_name) FROM campers AS T1
	WHERE t1.id = t2.driver_id) AS driver_name
FROM vehicles AS t2;