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
