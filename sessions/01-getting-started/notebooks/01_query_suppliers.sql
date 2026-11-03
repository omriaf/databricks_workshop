-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Query suppliers
-- MAGIC
-- MAGIC Start here after uploading `bakehouse_suppliers.csv` directly and creating
-- MAGIC `workspace.default.bakehouse_suppliers`, as shown in the workshop.
-- MAGIC If your catalog or schema has a different name, update the table references below.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Preview the data
-- MAGIC Each row represents one supplier. Check the columns before answering the business question.

-- COMMAND ----------

SELECT *
FROM workspace.default.bakehouse_suppliers
LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Where are our suppliers located?
-- MAGIC Count suppliers by continent. This measures the number of suppliers, rather than purchasing volume.

-- COMMAND ----------

SELECT
  continent,
  COUNT(*) AS supplier_count
FROM workspace.default.bakehouse_suppliers
GROUP BY continent
ORDER BY supplier_count DESC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Ask Genie Code
-- MAGIC
-- MAGIC > Write the same SQL logic as PySpark code: count suppliers by continent from
-- MAGIC > `workspace.default.bakehouse_suppliers`, name the count `supplier_count`,
-- MAGIC > sort from highest to lowest, and display the result.
-- MAGIC
-- MAGIC Use the generated code, or run the prepared Python cell below on notebook compute that supports Python.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC from pyspark.sql import functions as F
-- MAGIC
-- MAGIC df = spark.table("workspace.default.bakehouse_suppliers")
-- MAGIC
-- MAGIC (
-- MAGIC     df.groupBy("continent")
-- MAGIC     .agg(F.count("*").alias("supplier_count"))
-- MAGIC     .orderBy(F.col("supplier_count").desc())
-- MAGIC     .display()
-- MAGIC )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Create a bar chart
-- MAGIC In the SQL query result, select **Add visualization → Bar**.
-- MAGIC Choose `continent` for the category axis and `supplier_count` for the values.
-- MAGIC
-- MAGIC Expected result: **27 suppliers** in total, including **11 in Asia**.
-- MAGIC Next, open **02_load_suppliers_from_volume** to refresh this same table from a file in a Volume.
