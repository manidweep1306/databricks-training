-- Q1. Total order amount for each customer
SELECT customer_id,SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_id;

-- Q2. Top 3 customers by total spend
SELECT customer_id,SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 3;

-- Q3. Customers with no orders
SELECT c.*
FROM customers c
LEFT JOIN sales s
ON c.customer_id=s.customer_id
WHERE s.customer_id IS NULL;

-- Q4. City-wise total revenue
SELECT c.city,SUM(s.total_amount) AS total_revenue
FROM customers c
JOIN sales s
ON c.customer_id=s.customer_id
GROUP BY c.city;

-- Q5. Average order amount per customer
SELECT customer_id,AVG(total_amount) AS avg_order_amount
FROM sales
GROUP BY customer_id;

-- Q6. Customers with more than one order
SELECT customer_id,COUNT(*) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(*)>1;

-- Q7. Sort customers by total spend descending
SELECT customer_id,SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_id
ORDER BY total_spend DESC;