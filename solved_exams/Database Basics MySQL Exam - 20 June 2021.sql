-- 

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