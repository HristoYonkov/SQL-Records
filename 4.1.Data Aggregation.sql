------------------------------------- Grouping ------------------------
--Grouping allows taking data into separate groups based on a common property
SELECT e.`job_title`, count(employee_id)
FROM `employees` AS e
GROUP BY e.`job_title`;

---------------------------------- Aggregate Functions ----------------