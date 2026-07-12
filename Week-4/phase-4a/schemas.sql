-- PHASE 4A: Bucketing & Segmentation in SQL

-- Task 1: Gold/Silver/Bronze segmentation using CASE
SELECT 
    customer_id,
    customer_name,
    total_spend,
    CASE 
        WHEN total_spend > 10000 THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment
FROM customer_spend
ORDER BY total_spend DESC;

-- Task 2: Group data by segment and count customers
SELECT 
    CASE 
        WHEN total_spend > 10000 THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spend), 2) AS avg_spend,
    ROUND(SUM(total_spend), 2) AS total_revenue
FROM customer_spend
GROUP BY 
    CASE 
        WHEN total_spend > 10000 THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END
ORDER BY 
    CASE segment
        WHEN 'Gold' THEN 1
        WHEN 'Silver' THEN 2
        ELSE 3
    END;

-- Task 3: Quantile-based segmentation using NTILE
SELECT 
    customer_id,
    customer_name,
    total_spend,
    NTILE(3) OVER (ORDER BY total_spend) AS quantile_bucket,
    CASE 
        WHEN NTILE(3) OVER (ORDER BY total_spend) = 1 THEN 'Low'
        WHEN NTILE(3) OVER (ORDER BY total_spend) = 2 THEN 'Medium'
        ELSE 'High'
    END AS segment_label
FROM customer_spend
ORDER BY total_spend DESC;

-- Task 4: Window-based ranking using PERCENT_RANK
SELECT 
    customer_id,
    customer_name,
    total_spend,
    PERCENT_RANK() OVER (ORDER BY total_spend) AS percent_rank,
    CASE 
        WHEN PERCENT_RANK() OVER (ORDER BY total_spend) <= 0.33 THEN 'Low'
        WHEN PERCENT_RANK() OVER (ORDER BY total_spend) <= 0.66 THEN 'Medium'
        ELSE 'High'
    END AS rank_segment
FROM customer_spend
ORDER BY total_spend DESC;

-- Task 5: Compare all methods
WITH segments AS (
    SELECT 
        customer_id,
        customer_name,
        total_spend,
        CASE 
            WHEN total_spend > 10000 THEN 'Gold'
            WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
            ELSE 'Bronze'
        END AS conditional_segment,
        NTILE(3) OVER (ORDER BY total_spend) AS quantile_bucket
    FROM customer_spend
)
SELECT 
    'Conditional Logic' AS method,
    conditional_segment AS segment,
    COUNT(*) AS customer_count
FROM segments
GROUP BY conditional_segment
UNION ALL
SELECT 
    'Quantile-based' AS method,
    CASE 
        WHEN quantile_bucket = 1 THEN 'Low'
        WHEN quantile_bucket = 2 THEN 'Medium'
        ELSE 'High'
    END AS segment,
    COUNT(*) AS customer_count
FROM segments
GROUP BY quantile_bucket
ORDER BY method, segment;