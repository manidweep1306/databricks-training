-- Task 1: Daily Sales

SELECT
    sale_date,
    SUM(total_amount) AS daily_sales
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- Task 2: City-wise Revenue

SELECT
    c.city,
    SUM(s.total_amount) AS total_revenue
FROM customers c
JOIN sales s
ON c.customer_id=s.customer_id
GROUP BY c.city;

-- Task 3: Repeat Customers (>2 Orders)

SELECT
    customer_id,
    COUNT(*) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(*)>2;

-- Task 4: Highest Spending Customer in Each City

SELECT
    c.city,
    c.customer_id,
    SUM(s.total_amount) AS total_spend
FROM customers c
JOIN sales s
ON c.customer_id=s.customer_id
GROUP BY c.city,c.customer_id
ORDER BY total_spend DESC;

-- Task 5: Final Reporting Table

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    SUM(s.total_amount) AS total_spend,
    COUNT(*) AS order_count
FROM customers c
JOIN sales s
ON c.customer_id=s.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city;