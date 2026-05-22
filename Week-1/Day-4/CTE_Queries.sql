-- question 21
-- create a cte to calculate total sales per employee.

with employee_sales as (
    select
        employee_id,
        sum(total_amount) as total_sales
    from orders
    group by employee_id

)

select *
from employee_sales;


-- question 22
-- use a cte to find employees whose sales exceed the company average.

with employee_sales as (
    select
        employee_id,
        sum(total_amount) as total_sales
    from orders
    group by employee_id

),
average_sales as (
    select avg(total_sales) as avg_sales
    from employee_sales )

select es.*
from employee_sales es
cross join average_sales a
where es.total_sales > a.avg_sales;


-- question 23
-- create multiple ctes to calculate customer total spending and rankings.

with customer_spending as (
    select
        customer_id,
        sum(total_amount) as total_spending
    from orders
    group by customer_id

),
customer_rankings as (
    select
        customer_id,
        total_spending,

        rank() over (
            order by total_spending desc
        ) as spending_rank
    from customer_spending
)
select *
from customer_rankings;


-- question 24
-- write a recursive cte to generate numbers from 1 to 10.

with recursive numbers as (
    select 1 as num
    union all
    select num + 1
    from numbers
    where num < 10

)
select *
from numbers;


-- question 25
-- use a recursive cte to display employee hierarchy data.

with recursive employee_hierarchy as (
    select
        employee_id,
        employee_name,
        manager_id,
        1 as level
    from employees
    where manager_id is null
    union all
    select
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    from employees e
    join employee_hierarchy eh
        on e.manager_id = eh.employee_id
)
select *
from employee_hierarchy;


-- question 26
-- create a cte that filters orders above the average order amount.

with average_order as (
    select avg(total_amount) as avg_amount
    from orders

)
select o.*
from orders o
cross join average_order a
where o.total_amount > a.avg_amount;


-- question 27
-- use a cte and window function together to rank customers by total spending.

with customer_totals as (
    select
        customer_id,
        sum(total_amount) as total_spending
    from orders
    group by customer_id
)
select
    customer_id,
    total_spending,
    dense_rank() over (
        order by total_spending desc
    ) as spending_rank
from customer_totals;


-- question 28
-- find the second-highest salary in each department.

select * from (
    select
        employee_id,
        employee_name,
        department,
        salary,

        dense_rank() over (
            partition by department
            order by salary desc
        ) as salary_rank
    from employees
) ranked_employees
where salary_rank = 2;


-- question 29
-- display the difference between each employee salary
-- and the department maximum salary.

select
    employee_id,
    employee_name,
    department,
    salary,
    max(salary) over (
        partition by department
    ) - salary as salary_difference
from employees;


-- question 30
-- combine ctes and window functions to find
-- the top-performing employee in each department based on total sales.

with employee_sales as (
    select
        e.employee_id,
        e.employee_name,
        e.department,
        sum(o.total_amount) as total_sales
    from employees e
    join orders o
        on e.employee_id = o.employee_id
    group by
        e.employee_id,
        e.employee_name,
        e.department

),
ranked_employees as (

    select *,
        row_number() over (
            partition by department
            order by total_sales desc
        ) as rn
    from employee_sales
)
select * from ranked_employees
where rn = 1;
