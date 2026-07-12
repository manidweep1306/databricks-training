-- 1. Total order amount for each customer
SELECT customer_id, SUM(order_amount) AS total_amount
FROM orders WHERE customer_id IS NOT NULL
GROUP BY customer_id;

-- 2. Top 3 customers by total spend
SELECT customer_id, SUM(order_amount) AS total_spend
FROM orders WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_spend DESC LIMIT 3;

-- 3. Customers with no orders
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- 4. City-wise total revenue
SELECT c.city, SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- 5. Average order amount per customer
SELECT customer_id, AVG(order_amount) AS avg_amount
FROM orders WHERE customer_id IS NOT NULL
GROUP BY customer_id;

-- 6. Customers with more than one order
SELECT customer_id, COUNT(order_id) AS order_count
FROM orders WHERE customer_id IS NOT NULL
GROUP BY customer_id HAVING COUNT(order_id) > 1;

-- 7. Sort customers by total spend descending
SELECT customer_id, SUM(order_amount) AS total_spend
FROM orders WHERE customer_id IS NOT NULL
GROUP BY customer_id ORDER BY total_spend DESC;
