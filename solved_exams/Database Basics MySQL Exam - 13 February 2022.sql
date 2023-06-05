-- 01. Table Design
-- 02. Insert
-- 03. Update
-- 04. Delete
-- 05. Categories
-- 06. Quantity
-- 07. Review
-- 08. First customers
-- 09. Best categories
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