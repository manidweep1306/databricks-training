# Week 4 - Phase 2: SQL and PySpark Data Analysis

This phase-2 project analyzes customer and sales data with both SQL and PySpark. The SQL file and the PySpark pipeline implement the same seven analytical tasks so the two approaches can be compared side by side.

## Project Overview

- `etl_pipeline.py` loads the datasets, cleans missing customer IDs, casts `total_amount` to a numeric type, and runs the analysis with Spark DataFrame operations.
- `queries.sql` contains the SQL equivalents of the same tasks.
- `schemas.sql` documents the table structure used for the analysis.
- `screenshots/` stores the visual outputs captured from the completed tasks.

## Files in This Folder

```text
├── etl_pipeline.py
├── queries.sql
├── schemas.sql
├── README.md
└── screenshots/
```

## Data Used

The pipeline reads the following CSV files from `/samples`:

- `customers.csv`
- `sales.csv`

### customers.csv

| Column |
|--------|
| customer_id |
| first_name |
| last_name |
| email |
| city |
| state |

### sales.csv

| Column |
|--------|
| sale_id |
| customer_id |
| product_id |
| sale_date |
| quantity |
| total_amount |

## Analytical Tasks

1. Calculate total order amount for each customer.
2. Find the top 3 customers by total spend.
3. Identify customers with no orders.
4. Calculate city-wise total revenue.
5. Compute average order amount per customer.
6. Find customers with more than one order.
7. Sort customers by total spend in descending order.

## ETL Flow

```text
Load CSV data
        |
        v
Drop rows with missing customer_id
        |
        v
Cast total_amount to double
        |
        v
Run SQL and PySpark analysis
        |
        v
Review the resulting outputs
```

## How to Run

### In Databricks or Spark

Run the notebook or job with access to the `/samples` directory used in the script.

### With Spark Submit

```bash
spark-submit etl_pipeline.py
```

### With Python

```bash
python etl_pipeline.py
```

## Notes

- The script uses `left_anti` join logic to find customers with no orders.
- The SQL file mirrors the Spark logic for direct comparison.
- The outputs in `screenshots/` correspond to the seven analytical tasks above.

