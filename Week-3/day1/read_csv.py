# Reading Big Sales CSV File

df = spark.read.csv("/Volumes/workspace/default/day1files/Big Sales.csv", header=True)

df.show()

# Reading Employee Data CSV File

df2 = spark.read.csv("/Volumes/workspace/default/day1files/empData.csv", header=True)

df2.show()
