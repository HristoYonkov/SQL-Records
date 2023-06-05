-- 01. Table Design
-- 02. Insert
-- 03. Update
-- 04. Delete
-- 05. Categories
-- 06. Quantity
-- 07. Review
-- 08. First customers
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, c.address, o.order_datetime AS order_date
FROM customers AS c
JOIN orders as o ON o.customer_id = c.id
WHERE o.order_datetime <= '2018-12-31' 
ORDER BY full_name DESC;

-- 09. Best categories
SELECT COUNT(c.id) AS items_count, c.name, SUM(p.quantity_in_stock) AS total_quantity
from categories AS c
JOIN products AS p ON p.category_id = c.id
GROUP BY c.name
ORDER BY items_count DESC, total_quantity LIMIT 5;

-- 10. Extract clients cards count
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (
		SELECT COUNT(p.id) AS total_products
		FROM customers AS c
		JOIN orders AS o ON o.customer_id = c.id
		JOIN orders_products AS op ON op.order_id = o.id
		JOIN products AS p ON op.product_id = p.id
		WHERE first_name = `name`
);
END

-- 11. Reduce price
CREATE PROCEDURE udp_reduce_price(category_name VARCHAR(50))
BEGIN
	UPDATE products AS p
    JOIN categories AS c ON p.category_id = c.id
	JOIN reviews AS r ON r.id = p.review_id
    SET p.price = price * 0.70
	WHERE rating < 4 AND c.name = category_name;
END 