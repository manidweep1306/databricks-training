# Phase 3 - ETL Pipeline with SQL and PySpark

This phase-3 project demonstrates an end-to-end ETL flow using PySpark, with matching SQL logic stored in the schema file. It reads customer and sales CSV data, cleans invalid rows, computes a set of business summaries, and displays the final reporting table.

## Overview

- `etl_pipeline.py` contains the Spark-based ETL pipeline.
- `schemas.sql` contains the SQL versions of the same analytical tasks.
- `screenshots/` stores the output images for the completed tasks.

## Project Structure

```text
phase-3/
├── etl_pipeline.py
├── README.md
├── schemas.sql
└── screenshots/
```

## Data Used

The pipeline reads these CSV files from `/samples`:

- `customers.csv`
- `sales.csv`

### customers.csv

| Column |
|--------|
| customer_id |
| first_name |
| last_name |
| city |

### sales.csv

| Column |
|--------|
| sale_id |
| customer_id |
| sale_date |
| total_amount |

## Data Preparation

The pipeline performs the following steps before analysis:

- Loads the CSV datasets
- Removes rows with missing `customer_id`
- Casts `total_amount` to `double`
- Filters out rows where `total_amount` is not greater than zero

## Tasks Implemented

1. Calculate daily sales.
2. Calculate city-wise revenue.
3. Identify repeat customers with more than two orders.
4. Find the highest spending customer in each city.
5. Build the final reporting table.

## SQL to PySpark Mapping

| SQL | PySpark |
|------|----------|
| `SELECT` | `select()` |
| `WHERE` | `filter()` |
| `GROUP BY` | `groupBy()` |
| `SUM` | `agg(sum())` |
| `COUNT` | `agg(count())` |
| `JOIN` | `join()` |
| `ORDER BY` | `orderBy()` |
| `ROW_NUMBER()` | `row_number().over()` |

## ETL Workflow

```text
CSV files
     |
     v
Extract data
     |
     v
Clean and validate data
     |
     v
Transform data
     |
     v
Run business analysis
     |
     v
Display reports
```

## Output

The `screenshots/` folder contains outputs for the five tasks above:

- Daily sales
- City-wise revenue
- Repeat customers
- Highest spending customer by city
- Final reporting table

## Learning Outcomes

- ETL pipeline development
- Data cleaning and validation
- SQL to PySpark translation
- Aggregations and joins
- Window functions
- Business report generation

