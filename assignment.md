**Query #1**

    -- 1. Display employee name, department name, and salary
    SELECT e.emp_name, d.dept_name, e.salary 
    FROM employees e 
    JOIN departments d ON e.dept_id = d.dept_id;

| emp_name      | dept_name | salary   |
| ------------- | --------- | -------- |
| David Miller  | HR        | 65000.0  |
| Alice Smith   | IT        | 130000.0 |
| Bob Jones     | IT        | 95000.0  |
| Emma Wilson   | IT        | 95000.0  |
| Charlie Brown | Finance   | 110000.0 |
| Frank Thomas  | Finance   | 125000.0 |
| Grace Lee     | Marketing | 85000.0  |

---
**Query #2**

    -- 2. Show all departments and the number of employees in each department
    SELECT d.dept_name, COUNT(e.emp_id) AS employee_count 
    FROM departments d 
    LEFT JOIN employees e ON d.dept_id = e.dept_id 
    GROUP BY d.dept_name;

| dept_name | employee_count |
| --------- | -------------- |
| HR        | 1              |
| IT        | 3              |
| Finance   | 2              |
| Marketing | 1              |
| Sales     | 0              |

---
**Query #3**

    -- 3. Find employees along with their manager names
    SELECT e.emp_name AS employee_name, m.emp_name AS manager_name 
    FROM employees e 
    LEFT JOIN employees m ON e.manager_id = m.emp_id;

| employee_name | manager_name  |
| ------------- | ------------- |
| Alice Smith   |               |
| Bob Jones     | Alice Smith   |
| Charlie Brown |               |
| David Miller  |               |
| Emma Wilson   | Alice Smith   |
| Frank Thomas  | Charlie Brown |
| Grace Lee     |               |

---
**Query #4**

    -- 4. Find the total salary expenditure for each department
    SELECT d.dept_name, SUM(e.salary) AS total_salary 
    FROM employees e 
    JOIN departments d ON e.dept_id = d.dept_id 
    GROUP BY d.dept_name;

| dept_name | total_salary |
| --------- | ------------ |
| IT        | 320000.0     |
| Finance   | 235000.0     |
| HR        | 65000.0      |
| Marketing | 85000.0      |

---
**Query #5**

    -- 5. Find the average salary for each department
    SELECT d.dept_name, AVG(e.salary) AS average_salary 
    FROM employees e 
    JOIN departments d ON e.dept_id = d.dept_id 
    GROUP BY d.dept_name;

| dept_name | average_salary |
| --------- | -------------- |
| IT        | 106666.666667  |
| Finance   | 117500.0       |
| HR        | 65000.0        |
| Marketing | 85000.0        |

---
**Query #6**

    -- 6. Find the department with the highest average salary
    SELECT d.dept_name, AVG(e.salary) AS avg_salary 
    FROM employees e 
    JOIN departments d ON e.dept_id = d.dept_id 
    GROUP BY d.dept_name 
    ORDER BY avg_salary DESC 
    LIMIT 1;

| dept_name | avg_salary |
| --------- | ---------- |
| Finance   | 117500.0   |

---
**Query #7**

    -- 7. Find employees earning more than the company average salary
    SELECT emp_name, salary 
    FROM employees 
    WHERE salary > (SELECT AVG(salary) FROM employees);

| emp_name      | salary   |
| ------------- | -------- |
| Alice Smith   | 130000.0 |
| Charlie Brown | 110000.0 |
| Frank Thomas  | 125000.0 |

---
**Query #8**

    -- 8. Find employees earning more than their department average salary
    SELECT emp_name, salary, dept_id 
    FROM employees e 
    WHERE salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id);

| emp_name     | salary   | dept_id |
| ------------ | -------- | ------- |
| Alice Smith  | 130000.0 | 2       |
| Frank Thomas | 125000.0 | 3       |

---
**Query #9**

    -- 9. Find the second highest salary in the company
    SELECT MAX(salary) AS second_highest_salary 
    FROM employees 
    WHERE salary < (SELECT MAX(salary) FROM employees);

| second_highest_salary |
| --------------------- |
| 125000.0              |

---
**Query #10**

    -- 10. Find employees who earn the maximum salary in their department
    SELECT emp_name, dept_id, salary 
    FROM employees e 
    WHERE salary = (SELECT MAX(salary) FROM employees WHERE dept_id = e.dept_id);

| emp_name     | dept_id | salary   |
| ------------ | ------- | -------- |
| Alice Smith  | 2       | 130000.0 |
| David Miller | 1       | 65000.0  |
| Frank Thomas | 3       | 125000.0 |
| Grace Lee    | 4       | 85000.0  |

---
**Query #11**

    -- 11. Rank employees based on salary within each department
    SELECT emp_name, dept_id, salary, 
           RANK() OVER ( PARTITION BY dept_id ORDER BY salary DESC ) AS salary_rank
    FROM employees;

| emp_name      | dept_id | salary   | salary_rank |
| ------------- | ------- | -------- | ----------- |
| David Miller  | 1       | 65000.0  | 1           |
| Alice Smith   | 2       | 130000.0 | 1           |
| Bob Jones     | 2       | 95000.0  | 2           |
| Emma Wilson   | 2       | 95000.0  | 2           |
| Frank Thomas  | 3       | 125000.0 | 1           |
| Charlie Brown | 3       | 110000.0 | 2           |
| Grace Lee     | 4       | 85000.0  | 1           |

---
**Query #12**

    -- 12. Find the top 3 highest-paid employees in each department
    SELECT * FROM ( 
        SELECT emp_name, dept_id, salary, 
               DENSE_RANK() OVER ( PARTITION BY dept_id ORDER BY salary DESC ) AS rnk 
        FROM employees 
    ) t 
    WHERE rnk <= 3;

| emp_name      | dept_id | salary   | rnk |
| ------------- | ------- | -------- | --- |
| David Miller  | 1       | 65000.0  | 1   |
| Alice Smith   | 2       | 130000.0 | 1   |
| Bob Jones     | 2       | 95000.0  | 2   |
| Emma Wilson   | 2       | 95000.0  | 2   |
| Frank Thomas  | 3       | 125000.0 | 1   |
| Charlie Brown | 3       | 110000.0 | 2   |
| Grace Lee     | 4       | 85000.0  | 1   |

---
**Query #13**

    -- 13. Calculate running total salary ordered by hire date
    SELECT emp_name, hire_date, salary, 
           SUM(salary) OVER ( ORDER BY hire_date ) AS running_total_salary 
    FROM employees;

| emp_name      | hire_date  | salary   | running_total_salary |
| ------------- | ---------- | -------- | -------------------- |
| Charlie Brown | 2020-01-10 | 110000.0 | 110000.0             |
| Alice Smith   | 2021-03-15 | 130000.0 | 240000.0             |
| Grace Lee     | 2021-08-24 | 85000.0  | 325000.0             |
| Frank Thomas  | 2022-05-12 | 125000.0 | 450000.0             |
| Bob Jones     | 2022-06-20 | 95000.0  | 545000.0             |
| David Miller  | 2023-11-01 | 65000.0  | 610000.0             |
| Emma Wilson   | 2024-02-18 | 95000.0  | 705000.0             |

---
**Query #14**

    -- 14. Show previous employee salary using LAG()
    SELECT emp_name, salary, 
           LAG(salary) OVER ( ORDER BY hire_date ) AS previous_salary 
    FROM employees;

| emp_name      | salary   | previous_salary |
| ------------- | -------- | --------------- |
| Charlie Brown | 110000.0 |                 |
| Alice Smith   | 130000.0 | 110000.0        |
| Grace Lee     | 85000.0  | 130000.0        |
| Frank Thomas  | 125000.0 | 85000.0         |
| Bob Jones     | 95000.0  | 125000.0        |
| David Miller  | 65000.0  | 95000.0         |
| Emma Wilson   | 95000.0  | 65000.0         |

---
**Query #15**

    -- 15. Find customers who never placed an order
    SELECT c.customer_id, c.customer_name 
    FROM customers c 
    LEFT JOIN orders o ON c.customer_id = o.customer_id 
    WHERE o.order_id IS NULL;

| customer_id | customer_name |
| ----------- | ------------- |
| 3           | Bob Johnson   |
| 4           | John Doe      |

---
**Query #16**

    -- 16. Find the latest order for each customer
    SELECT * FROM ( 
        SELECT o.*, 
               ROW_NUMBER() OVER ( PARTITION BY customer_id ORDER BY order_date DESC) AS rn 
        FROM orders o 
    ) t 
    WHERE rn = 1;

| order_id | customer_id | order_date | amount | rn  |
| -------- | ----------- | ---------- | ------ | --- |
| 4        | 1           | 2026-04-12 | 400.0  | 1   |
| 6        | 2           | 2026-05-01 | 500.0  | 1   |

---
**Query #17**

    -- 17. Find total sales generated by each customer (Altered to fix duplicate name merge)
    SELECT c.customer_name, SUM(o.amount) AS total_sales 
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id 
    GROUP BY c.customer_id, c.customer_name;

| customer_name | total_sales |
| ------------- | ----------- |
| John Doe      | 1100.0      |
| Jane Smith    | 620.0       |

---
**Query #18**

    -- 18. Calculate customer contribution percentage to overall sales (Altered to fix duplicate name merge)
    SELECT c.customer_name, 
           ROUND( SUM(o.amount) * 100.0 / (SELECT SUM(amount) FROM orders), 2 ) AS contribution_percentage 
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id 
    GROUP BY c.customer_id, c.customer_name;

| customer_name | contribution_percentage |
| ------------- | ----------------------- |
| John Doe      | 63.95                   |
| Jane Smith    | 36.05                   |

---
**Query #19**

    -- 19. Identify duplicate customer names
    SELECT customer_name 
    FROM customers 
    GROUP BY customer_name 
    HAVING COUNT(*) > 1;

| customer_name |
| ------------- |
| John Doe      |

---
**Query #20**

    -- 20. Classify employees into salary bands
    SELECT emp_name, salary, 
           CASE 
               WHEN salary < 80000 THEN 'Low' 
               WHEN salary BETWEEN 80000 AND 120000 THEN 'Medium' 
               ELSE 'High' 
           END AS salary_band 
    FROM employees;

| emp_name      | salary   | salary_band |
| ------------- | -------- | ----------- |
| Alice Smith   | 130000.0 | High        |
| Bob Jones     | 95000.0  | Medium      |
| Charlie Brown | 110000.0 | Medium      |
| David Miller  | 65000.0  | Low         |
| Emma Wilson   | 95000.0  | Medium      |
| Frank Thomas  | 125000.0 | High        |
| Grace Lee     | 85000.0  | Medium      |

---
**Query #21**

    -- 21. Find employees having the same salary
    SELECT salary, COUNT(*) AS employee_count 
    FROM employees 
    GROUP BY salary 
    HAVING COUNT(*) > 1;

| salary  | employee_count |
| ------- | -------------- |
| 95000.0 | 2              |

---
**Query #22**

    -- 22. Find customers who placed more than 3 orders (Altered to fix duplicate name merge)
    SELECT c.customer_name, COUNT(o.order_id) AS total_orders 
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id 
    GROUP BY c.customer_id, c.customer_name 
    HAVING COUNT(o.order_id) > 3;

| customer_name | total_orders |
| ------------- | ------------ |
| John Doe      | 4            |

---
**Query #23**

    -- 23. Find the month with highest sales
    SELECT MONTH(order_date) AS sales_month, SUM(amount) AS total_sales 
    FROM orders 
    GROUP BY MONTH(order_date) 
    ORDER BY total_sales DESC 
    LIMIT 1;

| sales_month | total_sales |
| ----------- | ----------- |
| 5           | 500.0       |

---
**Query #24**

    -- 24. Calculate days between consecutive orders for each customer
    SELECT customer_id, order_date, 
           DATEDIFF( order_date, LAG(order_date) OVER ( PARTITION BY customer_id ORDER BY order_date ) ) AS days_between_orders 
    FROM orders;

| customer_id | order_date | days_between_orders |
| ----------- | ---------- | ------------------- |
| 1           | 2026-01-10 |                     |
| 1           | 2026-02-15 | 36                  |
| 1           | 2026-03-05 | 18                  |
| 1           | 2026-04-12 | 38                  |
| 2           | 2025-11-22 |                     |
| 2           | 2026-05-01 | 160                 |

---
**Query #25**

    -- 25. Find departments where no employee was hired in the last 2 years (Altered anchor date)
    SELECT d.dept_name 
    FROM departments d 
    JOIN employees e ON d.dept_id = e.dept_id 
    GROUP BY d.dept_name 
    HAVING MAX(e.hire_date) < CAST('2026-06-10' AS DATE) - INTERVAL 2 YEAR;

| dept_name |
| --------- |
| IT        |
| Finance   |
| HR        |
| Marketing |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/vbSyE7jLUfzReeqGXjGtst/1)
