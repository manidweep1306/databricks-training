# PHASE 4A: Bucketing & Segmentation in PySpark

from pyspark.sql import SparkSession
from pyspark.sql.functions import when, col, count, sum as spark_sum, avg, percent_rank, concat, lit
from pyspark.sql.types import DoubleType, IntegerType, StringType, StructType, StructField
from pyspark.ml.feature import Bucketizer
from pyspark.sql.window import Window

spark = SparkSession.builder.appName('Phase4A_Bucketing').getOrCreate()

# Load customers dataset
customers = spark.read.format('csv').option('header', 'true').option('inferSchema', 'true').load('/samples/customers.csv')
customers = customers.withColumn("customer_name", concat(col("first_name"), lit(" "), col("last_name")))

# Create sample orders data
orders_data = [
    (1, 1, 1500.00, "2024-01-15"), (2, 2, 8000.00, "2024-01-20"),
    (3, 3, 12000.00, "2024-02-01"), (4, 1, 4500.00, "2024-02-10"),
    (5, 4, 22000.00, "2024-02-15"), (6, 5, 3000.00, "2024-03-01"),
    (7, 1, 18000.00, "2024-03-05"), (8, 6, 6000.00, "2024-03-10"),
    (9, 2, 9500.00, "2024-03-15"), (10, 7, 7500.00, "2024-03-20"),
    (11, 3, 2500.00, "2024-04-01"), (12, 4, 14000.00, "2024-04-05"),
    (13, 8, 5500.00, "2024-04-10"), (14, 5, 9000.00, "2024-04-15"),
    (15, 6, 11000.00, "2024-04-20"),
]

orders_schema = StructType([
    StructField("order_id", IntegerType(), True),
    StructField("customer_id", IntegerType(), True),
    StructField("total_amount", DoubleType(), True),
    StructField("order_date", StringType(), True)
])
orders = spark.createDataFrame(orders_data, orders_schema)

# Create customer spend data
customer_spend = orders.groupBy("customer_id").agg(spark_sum("total_amount").alias("total_spend"))
customer_spend = customer_spend.join(customers, "customer_id").select("customer_id", "customer_name", "total_spend").dropna()

print("Customer Spend Data:")
customer_spend.show(10)

# Task 1: Conditional Logic (Gold/Silver/Bronze)
print("\nTask 1: Gold/Silver/Bronze Segmentation")
segmented_df = customer_spend.withColumn(
    "segment",
    when(col("total_spend") > 10000, "Gold")
    .when((col("total_spend") >= 5000) & (col("total_spend") <= 10000), "Silver")
    .otherwise("Bronze")
)
segmented_df.select("customer_name", "total_spend", "segment").show(10)

# Task 2: Group by Segment and Count
print("\nTask 2: Segment Statistics")
segment_counts = segmented_df.groupBy("segment").agg(
    count("*").alias("customer_count"),
    avg("total_spend").alias("avg_spend"),
    spark_sum("total_spend").alias("total_revenue")
).orderBy(col("segment"))
segment_counts.show()

# Task 3: Bucketizer (MLlib)
print("\nTask 3: Bucketizer Results")
customer_spend_float = customer_spend.withColumn("total_spend_float", col("total_spend").cast(DoubleType()))
splits = [-float("inf"), 5000, 10000, float("inf")]
bucketizer = Bucketizer(splits=splits, inputCol="total_spend_float", outputCol="bucket")
bucketed_df = bucketizer.transform(customer_spend_float)
bucketed_df = bucketed_df.withColumn(
    "segment_bucket",
    when(col("bucket") == 0, "Bronze")
    .when(col("bucket") == 1, "Silver")
    .when(col("bucket") == 2, "Gold")
    .otherwise("Unknown")
)
bucketed_df.select("customer_name", "total_spend", "segment_bucket").show(10)

# Task 4: Quantile-based Segmentation
print("\nTask 4: Quantile-based Segmentation")
quantiles = customer_spend.approxQuantile("total_spend", [0.33, 0.66, 1.0], 0.01)
print(f"Quantiles: 33% = {quantiles[0]:.2f}, 66% = {quantiles[1]:.2f}")
quantile_segmented = customer_spend.withColumn(
    "quantile_segment",
    when(col("total_spend") <= quantiles[0], "Low")
    .when((col("total_spend") > quantiles[0]) & (col("total_spend") <= quantiles[1]), "Medium")
    .otherwise("High")
)
quantile_segmented.select("customer_name", "total_spend", "quantile_segment").show(10)

# Task 5: Window-based Ranking
print("\nTask 5: Window-based Ranking")
window_spec = Window.orderBy("total_spend")
ranked_df = customer_spend.withColumn("percent_rank", percent_rank().over(window_spec))
ranked_df = ranked_df.withColumn(
    "rank_segment",
    when(col("percent_rank") <= 0.33, "Low")
    .when((col("percent_rank") > 0.33) & (col("percent_rank") <= 0.66), "Medium")
    .otherwise("High")
)
ranked_df.select("customer_name", "total_spend", "percent_rank", "rank_segment").show(10)

# Method Comparison
print("\nMethod Comparison - Segment Distributions")
print("Method 1 (Conditional Logic):")
segmented_df.groupBy("segment").count().show()
print("Method 3 (Bucketizer):")
bucketed_df.groupBy("segment_bucket").count().show()
print("Method 4 (Quantile-based):")
quantile_segmented.groupBy("quantile_segment").count().show()
print("Method 5 (Window Ranking):")
ranked_df.groupBy("rank_segment").count().show()

# Final Comparison
print("\nFinal Comparison - All Methods Side by Side")
final_comparison = segmented_df.select("customer_name", "total_spend", "segment") \
    .join(bucketed_df.select("customer_name", "segment_bucket"), "customer_name") \
    .join(quantile_segmented.select("customer_name", "quantile_segment"), "customer_name") \
    .join(ranked_df.select("customer_name", "rank_segment"), "customer_name")
final_comparison.show(15)

# Reflection Questions
print("\nReflection Questions")
print("1. Why do we convert continuous values into categories?")
print("   - Simplify analysis and reporting")
print("   - Make data more understandable to business users")
print("   - Enable segmentation-based strategies")
print("\n2. Difference between business segmentation and technical bucketing?")
print("   - Business segmentation: Based on business rules (Gold/Silver/Bronze)")
print("   - Technical bucketing: Statistical division (equal frequency)")
print("\n3. When would fixed thresholds fail?")
print("   - When data distribution changes significantly")
print("   - When business goals change")
print("   - When new customer segments emerge")
print("\n4. How does quantile-based segmentation differ from fixed rules?")
print("   - Quantile-based: Adapts to data distribution")
print("   - Fixed rules: Stable but may become outdated")
print("\n5. Which method would you use in real-world projects?")
print("   - Fixed rules for consistent branding (Gold/Silver/Bronze)")
print("   - Quantile-based for dynamic segmentation")
print("   - ML methods for complex segmentation")

print("\nPHASE 4A COMPLETED SUCCESSFULLY!")