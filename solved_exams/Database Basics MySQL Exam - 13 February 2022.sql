
-- 01. Table Design
CREATE TABLE brands (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE reviews (
	id INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT,
    rating DECIMAL(10, 2) NOT NULL,
    picture_url VARCHAR(80) NOT NULL,
    published_at DATETIME NOT NULL
);

CREATE TABLE products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    price DECIMAL(19, 2) NOT NULL,
    quantity_in_stock INT,
    description TEXT,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    review_id INT,
    FOREIGN KEY(brand_id) REFERENCES brands (id),
    FOREIGN KEY(category_id) REFERENCES categories (id),
    FOREIGN KEY(review_id) REFERENCES reviews (id)
);

CREATE TABLE customers (
	id	INT PRIMARY KEY AUTO_INCREMENT,
	first_name	VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	phone VARCHAR(30) NOT NULL UNIQUE,
    address VARCHAR(60) NOT NULL,
    discount_card BIT(1) NOT NULL
);

CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_datetime DATETIME NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customers (id)
);

CREATE TABLE orders_products (
	order_id INT,
    product_id INT,
    FOREIGN KEY(order_id) REFERENCES orders (id),
    FOREIGN KEY(product_id) REFERENCES products (id)
);

-- 02. Insert
INSERT INTO reviews(content, picture_url, published_at, rating) (
SELECT 
SUBSTRING(description, 1, 15), 
REVERSE(name), 
'2010-10-10', 
(price / 8) 
FROM products
WHERE id >= 5
);

-- 03. Update
UPDATE products
SET quantity_in_stock = quantity_in_stock - 5
WHERE quantity_in_stock BETWEEN 60 AND 70;

-- 04. Delete
DELETE FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);

-- 05. Categories
SELECT 
id ,
name
FROM categories
ORDER BY name DESC;
-- 06. Quantity
SELECT id, brand_id , name, quantity_in_stock
FROM products
WHERE price > 1000 AND quantity_in_stock < 30
ORDER BY quantity_in_stock, id; 

-- 07. Review
SELECT
id,
content,
rating,
picture_url,
published_at
FROM reviews
WHERE content LIKE 'My%' AND CHAR_LENGTH(content) > 61
ORDER BY rating DESC;

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