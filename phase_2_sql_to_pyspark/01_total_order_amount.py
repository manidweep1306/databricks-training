from pyspark.sql import SparkSession
import pyspark.sql.functions as F

spark = SparkSession.builder.appName("DataEngineeringPipeline").getOrCreate()

# 1. EXTRACT
customers_df = spark.read.format("csv").option("header", "true").load("/samples/customers.csv")
orders_df = spark.read.format("csv").option("header", "true").load("/samples/orders.csv")

# 2. TRANSFORM: CLEANING
customers_clean = customers_df.dropna(subset=["customer_id"]).dropDuplicates(["customer_id"])
orders_clean = orders_df.dropna(subset=["customer_id"]).dropDuplicates(["order_id"])

orders_clean = orders_clean.withColumn("order_amount", F.col("order_amount").cast("double")) \
                           .filter(F.col("order_amount") >= 0)

# 3. TRANSFORM: BUSINESS LOGIC & BUCKETING
customer_summary = orders_clean.groupBy("customer_id") \
    .agg(
        F.sum("order_amount").alias("total_spend"),
        F.count("order_id").alias("order_count")
    )

customer_segmented = customer_summary.withColumn(
    "segment",
    F.when(F.col("total_spend") > 10000, "Gold")
     .when((F.col("total_spend") >= 5000) & (F.col("total_spend") <= 10000), "Silver")
     .otherwise("Bronze")
)

# 4. FINAL REPORTING TABLE
final_reporting_table = customers_clean.join(customer_segmented, on="customer_id", how="inner") \
    .select("customer_name", "city", "total_spend", "order_count", "segment")

print("--- FINAL PIPELINE OUTPUT ---")
final_reporting_table.show(10)

# 5. LOAD (Save Output)
final_reporting_table.write.mode("overwrite").csv("/samples/output/report")
print("Pipeline Successfully Completed and Saved.")
