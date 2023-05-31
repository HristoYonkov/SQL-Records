-- 1.Managers
SELECT departments.manager_id AS employee_id,
CONCAT(employees.first_name, ' ', employees.last_name) AS full_name,
departments.department_id,
name AS department_name
FROM
departments
    LEFT JOIN
employees
ON employees.employee_id = departments.manager_id
ORDER BY employee_id
LIMIT 5;

-- 2. Towns and Addresses
SELECT towns.town_id,
name AS town_name,
address_text 
FROM towns
JOIN addresses ON towns.town_id = addresses.town_id
WHERE towns.name IN('San Francisco', 'Sofia', 'Carnation')
ORDER BY town_id, address_id;

-- 3. Employees Without Managers
SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE manager_id IS NULL;

-- 4. High Salary
SELECT COUNT(*) AS count
FROM employees
WHERE salary > (
SELECT AVG(salary) FROM employees
);

-- Big SUBQUERY JOINS EXAMPLE!
SELECT 
p.project_id,
p.name,
COUNT(ep.employee_id) AS 'ALL Employees',
(
SELECT COUNT(e1.employee_id)
	FROM employees_projects AS ep1
	JOIN employees AS e1 ON ep1.employee_id = e1.employee_id
	JOIN addresses AS a1 ON e1.address_id = a1.address_id
	JOIN employees AS e1 ON ep1.employee_id = e1.employee_id
	WHERE t.name = 'Bellevue' AND ep1.project_id = p.project_id
) AS 'Bell Employees'
FROM projects AS p
	JOIN employees_projects AS ep ON ep.project_id = p.project_id
	JOIN employees AS e ON ep.employee_id = e.employee_id
	JOIN addresses AS a ON e.address_id = a.address_id
	JOIN towns AS t ON a.town_id = t.town_id
GROUP BY p.project_id
HAVING `Bell Employees` > `ALL Employees`
ORDER BY project_id
LIMIT 200;