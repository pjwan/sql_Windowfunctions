'''
The dataset belongs to "Data With Danny." 
I use the salary table from the employees schema for this exercise.
The salary table shows employee salary, employment start and end date.
Please refer to the Query_result.pdf for screenshot images of the salary table and query results.
'''
-- Q1. Query top 10 employees by salary reported.
SELECT 
    employee_id AS id,
    amount AS salary,
    RANK() OVER (
        ORDER BY amount DESC
    ) AS salary_rank
FROM employees.salary
LIMIT 10;
---- OR without LIMIT
SELECT 
    tb1.id,
    tb1.salary,
    tb1.salary_rank
FROM (
    SELECT 
        employee_id AS id,
        amount AS salary,
        RANK() OVER (
            ORDER BY amount DESC
        ) AS salary_rank
    FROM employees.salary
    ) AS tb1
WHERE salary_rank < 11

-- Q2: Turns out employees reported multiple salaries. 
-- Count the number of rows per employee.
SELECT 
  employee_id AS id,
  COUNT(*) AS freq
FROM employees.salary
GROUP BY 1
ORDER BY 1;

-- Q3. Query salary, the sum and average of salary per employee 
SELECT  
    employee_id AS id,
    amount AS salary,
    SUM(amount) OVER (
        PARTITION BY employee_id
    ) AS sum_salary,
    ROUND(
      AVG(amount) OVER (
        PARTITION BY employee_id
    ), 2) AS avg_salary
FROM employees.salary;

-- Q4. Query top 10 employees by average salary.
SELECT 
  employee_id,
  ROUND(avg_amount, 2),
  RANK() OVER (
    ORDER BY avg_amount DESC
    ) AS avg_rank
FROM (
  SELECT 
    employee_id,
    AVG(amount) as avg_amount
  FROM employees.salary
  GROUP BY 1
  ) AS tb2
LIMIT 10;