from pyspark.sql import SparkSession
import pyspark.sql.functions as F
from pyspark.sql.window import Window

# Initialize Spark Session (managed automatically in Databricks/Playground)
spark = SparkSession.builder.appName("Phase3_ETL").getOrCreate()

# ==========================================
# 1. EXTRACT (Read & Inspect)
# ==========================================
print("--- 1. Extracting Data & Inspecting Schema ---")
customers = spark.read.option("header", "true").csv("/samples/customers.csv")
orders = spark.read.option("header", "true").csv("/samples/orders.csv")

customers.printSchema()
orders.printSchema()

# ==========================================
# 2. TRANSFORM (Data Cleaning)
# ==========================================
print("--- 2. Cleaning Data ---")
# Clean nulls
customers_clean = customers.dropna(subset=["customer_id"])
orders_clean = orders.dropna(subset=["customer_id"])

# Filter invalid records (e.g., negative order amounts) and cast types
orders_clean = orders_clean.withColumn("order_amount", F.col("order_amount").cast("double")) \
                           .filter(F.col("order_amount") > 0)

# ==========================================
# 3. TRANSFORM (Business Pipeline Exercises)
# ==========================================

# Exercise 1: Read sales data -> clean nulls -> calculate daily sales
print("--- Pipeline 1: Daily Sales ---")
daily_sales = orders_clean.groupBy("order_date").agg(F.sum("order_amount").alias("total_sales"))
daily_sales.show()

# Exercise 2: Read customer data -> clean invalid rows -> city-wise revenue
print("--- Pipeline 2: City-wise Revenue ---")
city_revenue = customers_clean.join(orders_clean, on="customer_id", how="inner") \
    .groupBy("city").agg(F.sum("order_amount").alias("total_revenue"))
city_revenue.show()

# Exercise 3: Find repeat customers (>2 orders as per Phase 3 instructions)
print("--- Pipeline 3: Repeat Customers (>2 orders) ---")
repeat_customers = orders_clean.groupBy("customer_id") \
    .agg(F.count("order_id").alias("order_count")) \
    .filter(F.col("order_count") > 2)
repeat_customers.show()

# Exercise 4: Find highest spending customer in each city
print("--- Pipeline 4: Highest Spending Customer per City ---")
customer_spend = customers_clean.join(orders_clean, on="customer_id", how="inner") \
    .groupBy("city", "customer_name") \
    .agg(F.sum("order_amount").alias("total_spend"))

# Using a Window function to rank spenders per city and filter for the top 1
windowSpec = Window.partitionBy("city").orderBy(F.col("total_spend").desc())
highest_spender_per_city = customer_spend.withColumn("rank", F.rank().over(windowSpec)) \
    .filter(F.col("rank") == 1).drop("rank")
highest_spender_per_city.show()

# Exercise 5: Build final reporting table with customer, city, total spend, order count
print("--- Pipeline 5: Final Reporting Table ---")
customer_orders_agg = orders_clean.groupBy("customer_id") \
    .agg(F.sum("order_amount").alias("total_spend"), F.count("order_id").alias("order_count"))

final_report = customers_clean.join(customer_orders_agg, on="customer_id", how="inner") \
    .select("customer_name", "city", "total_spend", "order_count")

final_report.show()

# ==========================================
# 4. LOAD
# ==========================================
print("--- Saving Pipeline Output ---")
# Writing the final table back to the sample output directory
final_report.write.mode("overwrite").csv("/samples/output/phase3_report")
print("Pipeline Successfully Completed!")
