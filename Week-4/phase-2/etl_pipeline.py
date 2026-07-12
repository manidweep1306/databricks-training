from pyspark.sql import SparkSession
from pyspark.sql.functions import sum,avg,count,col

spark=SparkSession.builder.appName("Phase2").getOrCreate()

customers=spark.read.option("header","true").csv("/samples/customers.csv")
sales=spark.read.option("header","true").csv("/samples/sales.csv")

customers=customers.dropna(subset=["customer_id"])
sales=sales.dropna(subset=["customer_id"])

sales=sales.withColumn("total_amount",col("total_amount").cast("double"))

#Task 1: Total order amount for each customer

sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_spend")) \
    .show()

#Task 2:Top 3 customers by total spend

sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_spend")) \
    .orderBy(col("total_spend").desc()) \
    .limit(3) \
    .show()

#Task 3:Customers with no orders

customers.join(sales,"customer_id","left_anti").show()

#Task 4:City-wise total revenue

customers.join(sales,"customer_id") \
    .groupBy("city") \
    .agg(sum("total_amount").alias("total_revenue")) \
    .show()

#Task 5:Average order amount per customer

sales.groupBy("customer_id") \
    .agg(avg("total_amount").alias("avg_order_amount")) \
    .show()

#Task 6:Customers with more than one order

sales.groupBy("customer_id") \
    .agg(count("*").alias("order_count")) \
    .filter(col("order_count")>1) \
    .show()

#Task 7:Sort customers by total spend descending

sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_spend")) \
    .orderBy(col("total_spend").desc()) \
    .show()