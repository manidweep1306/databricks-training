# 🚀 Phase 4A – Bucketing & Segmentation in PySpark

<div align="center">

![PySpark](https://img.shields.io/badge/PySpark-3.5.5-orange?style=for-the-badge&logo=apachespark)
![Python](https://img.shields.io/badge/Python-3.8+-blue?style=for-the-badge&logo=python)
![SQL](https://img.shields.io/badge/SQL-ANSI_SQL-green?style=for-the-badge&logo=mysql)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

**Customer Segmentation using SQL & PySpark**

</div>

---

# 📖 Overview

This project demonstrates multiple customer segmentation (bucketing) techniques using **SQL** and **PySpark**. It converts continuous customer spending into meaningful categories such as **Gold**, **Silver**, and **Bronze**, while also comparing statistical approaches like **Bucketizer**, **Quantile Segmentation**, and **Window Ranking**.

---

# 🛠️ Tech Stack

- 🐍 Python 3.8+
- ⚡ PySpark 3.5.5
- 🔥 Apache Spark
- 🗄️ SQL
- 📄 CSV Dataset

---

# 📂 Project Structure

```text
Week4/
└── phase-4a/
    ├── etl_pipeline.py
    ├── queries.sql
    ├── README.md
    └── screenshots/
        ├── gold_silver_bronze.png
        ├── segment_counts.png
        ├── quantile_segments.png
        ├── method_comparison.png
        └── reflection_notes.png
```

---

# 📊 Dataset

### 👥 customers.csv

Contains customer information:

- customer_id
- first_name
- last_name
- email
- city
- state

### 💰 orders (Sample Dataset)

Created within the PySpark program.

- order_id
- customer_id
- total_amount
- order_date

---

# 🧹 Data Preparation

Before analysis, the following steps were performed:

- Loaded customer dataset
- Created sample orders dataset
- Calculated total customer spending
- Joined customer and spending data
- Removed null values
- Prepared data for segmentation

---

# 📈 Tasks Implemented

| Task | Description |
|------|-------------|
| ✅ Task 1 | Gold / Silver / Bronze Segmentation |
| ✅ Task 2 | Segment-wise Customer Statistics |
| ✅ Task 3 | MLlib Bucketizer |
| ✅ Task 4 | Quantile-based Segmentation |
| ✅ Task 5 | Window-based Ranking |
| ✅ Task 6 | Compare All Segmentation Methods |

---

# 🔄 SQL to PySpark Mapping

| SQL | PySpark |
|------|----------|
| SELECT | `select()` |
| WHERE | `filter()` |
| GROUP BY | `groupBy()` |
| CASE WHEN | `when()` |
| SUM | `agg(sum())` |
| AVG | `agg(avg())` |
| COUNT | `agg(count())` |
| JOIN | `join()` |
| ORDER BY | `orderBy()` |
| PERCENT_RANK | `percent_rank()` |

---

# ⚙️ Workflow

```text
Customers Dataset
        │
        ▼
Load into Spark
        │
        ▼
Create Orders Dataset
        │
        ▼
Calculate Total Spend
        │
        ▼
Customer Segmentation
        │
        ▼
Statistics & Comparison
        │
        ▼
Business Insights
```

---

# 📷 Output

The **screenshots/** folder contains execution results for:

- 🥇 Gold / Silver / Bronze Segmentation
- 📊 Segment Statistics
- 📉 Quantile Segmentation
- 🔄 Method Comparison
- 📝 Reflection Notes

---

# 💡 Key Concepts

- Customer Segmentation
- Conditional Logic (`when()`)
- SQL CASE Statements
- Spark MLlib Bucketizer
- Quantile Analysis
- Window Functions (`percent_rank`)
- SQL to PySpark Translation

---

# 📝 Reflection

- Continuous values are categorized to simplify analysis and business reporting.
- Business segmentation uses predefined rules, while technical bucketing is based on data distribution.
- Fixed thresholds may become less effective as customer behavior changes.
- Quantile segmentation adapts automatically to changing datasets.
- The best segmentation method depends on business requirements and data characteristics.

---

# 🎯 Learning Outcomes

- Customer Segmentation Techniques
- SQL & PySpark Integration
- Data Aggregation and Analysis
- Window Functions
- MLlib Bucketizer
- Quantile-based Bucketing
- Business Analytics

---

# 🚀 Future Improvements

- Use real-world e-commerce datasets
- Read data from MySQL/PostgreSQL using JDBC
- Store processed data in Parquet format
- Visualize insights using Power BI or Tableau

---
