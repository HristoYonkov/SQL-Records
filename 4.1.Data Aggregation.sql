-- 1. Departments Info
SELECT department_id, count(first_name) AS 'Number of employees'
FROM employees
GROUP BY department_id;

-- 2. Average Salary
SELECT department_id, ROUND(AVG(salary), 2) AS 'Average Salary'
FROM employees
GROUP BY department_id;

-- 3. Minimum Salary
SELECT department_id, ROUND(MIN(salary), 2) AS 'Min Salary'
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 800;

-- 4. Appetizers Count
select  COUNT(*) AS 'count'
from products
WHERE category_id = 2 AND price > 8;

-- 5. Menu Prices
SELECT category_id,
ROUND(AVG(price), 2) AS 'Average Price',
ROUND(MIN(price), 2) AS 'Cheapest Product',
ROUND(MAX(price), 2) AS 'Most Expensive Product'
FROM products
GROUP BY category_id;

------------------------------------- Grouping -------------------------------
GROUP BY --Grouping allows taking data into separate groups based on a common property
SELECT e.`job_title`, count(employee_id)
FROM `employees` AS e
GROUP BY e.`job_title`;

---------------------------------- Aggregate Functions -----------------------
'COUNT, SUM, MAX, MIN, AVG…' -- Used to operate over one or more groups -
--performing data analysis on every one. They usually ignore NULL values.

COUNT() -- counts the values (not nulls) in one or more columns -
--based on grouping criteria

SUM() -- sums the values in a column.
MAX() -- takes the maximum value in a column.
MIN() -- takes the minimum value in a column. 
AVG() -- calculates the average value in a column.

'HAVING' -- The HAVING clause is used to filter data based on aggregate values.
-- We cannot use it without grouping before that
-- Any Aggregate functions in the "HAVING" clause and in the-
-- "SELECT" statement are executed one time only
-- Unlike HAVING, the WHERE clause filters rows before the
-- aggregation
SELECT department_id, SUM(salary) as 'Min Salary'
from employees
GROUP BY department_id
HAVING `Min Salary` < 4300;
