# Day 1 - Reading CSV Files using PySpark

## Objective
Learn how to read CSV files and display data using PySpark in Databricks.

---

## Files Used
- Big Sales.csv
- empData.csv

---

## PySpark Code

```python
# Reading Big Sales CSV File

df = spark.read.csv("/Volumes/workspace/default/day1files/Big Sales.csv", header=True)

df.show()

# Reading Employee Data CSV File

df2 = spark.read.csv("/Volumes/workspace/default/day1files/empData.csv", header=True)

df2.show()
```

---

## Concepts Learned

- Databricks Workspace
- Volume Creation
- Uploading CSV Files
- Reading CSV using PySpark
- DataFrame
- show() function

---

## Output

Successfully displayed CSV data using PySpark in Databricks.
