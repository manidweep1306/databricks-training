-- Question 1
-- Use ROW_NUMBER() to assign a row number to employees ordered by salary descending.

select e.*,
  ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_number_rank
from employees e;


-- Question 2
-- Use RANK() to rank employees by salary.

select e.*,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
from employees e;


-- Question 3
-- Use DENSE_RANK() to rank employees by salary.

select e.*,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS dense_salary_rank
from employees e;


-- Question 4
-- Find the top 3 highest-paid employees using a window function.

select * from (
    select e.*,
        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS rn from employees e
) ranked_employees
WHERE rn <= 3;


-- Question 5
-- Rank employees within each department using PARTITION BY.

select e.*, RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank from employees e;


-- Question 6
-- Display the highest salary in each department using a window function.

select e.*, MAX(salary) OVER (
        PARTITION BY department
    ) AS highest_department_salary from employees e;


-- Question 7
-- Calculate the running total of order amounts ordered by order_date.

select order_id,
    customer_id,
    employee_id,
    order_date,
    total_amount,

    SUM(total_amount) OVER (
        ORDER BY order_date
    ) AS running_total from orders;


-- Question 8
-- Calculate the cumulative sales amount for each employee.

select employee_id,
    order_id,
    order_date,
    total_amount,

    SUM(total_amount) OVER (
        PARTITION BY employee_id
        ORDER BY order_date
    ) AS cumulative_sales from orders;


-- Question 9
-- Use LAG() to show the previous order amount for each customer.

select customer_id,
    order_id,
    order_date,
    total_amount,

    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount from orders;


-- Question 10
-- Use LEAD() to show the next order amount for each customer.

select customer_id,
    order_id,
    order_date,
    total_amount,

    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_amount from orders;
