-- 1.Managers
SELECT 
    departments.manager_id AS employee_id,
    CONCAT(employees.first_name, ' ', employees.last_name) AS full_name,
    departments.department_id,
    name AS department_name
FROM
    departments
        INNER JOIN
    employees
    WHERE employees.employee_id = departments.manager_id
    ORDER BY employee_id
    LIMIT 5;

