from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.window import Window

spark=SparkSession.builder.appName("Phase3").getOrCreate()

customers=spark.read.option("header","true").csv("/samples/customers.csv")
sales=spark.read.option("header","true").csv("/samples/sales.csv")

customers=customers.dropna(subset=["customer_id"])
sales=sales.dropna(subset=["customer_id"])

sales=sales.withColumn("total_amount",col("total_amount").cast("double"))
sales=sales.filter(col("total_amount")>0)

# Task 1: Daily Sales
daily_sales=sales.groupBy("sale_date") \
    .agg(sum("total_amount").alias("daily_sales")) \
    .orderBy("sale_date")

print("Task 1: Daily Sales")
daily_sales.show()

# Task 2: City-wise Revenue
city_revenue=customers.join(
    sales,
    "customer_id"
).groupBy("city") \
 .agg(sum("total_amount").alias("total_revenue"))

print("Task 2: City-wise Revenue")
city_revenue.show()

# Task 3: Repeat Customers (>2 Orders)
repeat_customers=sales.groupBy("customer_id") \
    .agg(count("*").alias("order_count")) \
    .filter(col("order_count")>2)

print("Task 3: Repeat Customers")
repeat_customers.show()

# Task 4: Highest Spending Customer in Each City
customer_spend=customers.join(
    sales,
    "customer_id"
).groupBy(
    "city",
    "customer_id",
    "first_name",
    "last_name"
).agg(
    sum("total_amount").alias("total_spend")
)

window=Window.partitionBy("city") \
    .orderBy(col("total_spend").desc())

highest_spenders=customer_spend.withColumn(
    "rank",
    row_number().over(window)
).filter(col("rank")==1)

print("Task 4: Highest Spending Customer in Each City")
highest_spenders.show()

# Task 5: Final Reporting Table
final_report=customers.join(
    sales,
    "customer_id"
).groupBy(
    "customer_id",
    "first_name",
    "last_name",
    "city"
).agg(
    sum("total_amount").alias("total_spend"),
    count("*").alias("order_count")
)

print("Task 5: Final Reporting Table")
final_report.show()

display(final_report)