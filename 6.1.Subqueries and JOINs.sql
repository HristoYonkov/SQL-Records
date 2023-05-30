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