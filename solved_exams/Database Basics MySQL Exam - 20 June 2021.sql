
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