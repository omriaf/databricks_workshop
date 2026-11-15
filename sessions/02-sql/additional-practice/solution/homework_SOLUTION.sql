-- =====================================================================
-- Webinar 2/6 · Homework — instructor solution
-- Prerequisite: sections 3–4 of session2_demo.sql have run
-- =====================================================================

-- Task 1 — the late file (same statement as the homework guide)
INSERT OVERWRITE DIRECTORY '/Volumes/workspace/session1_practice/source_files/late'
USING CSV OPTIONS (header 'true')
SELECT transactionID + 10000 AS transactionID,
       customerID,
       IF(transactionID % 100 = 0, 3000048, franchiseID) AS franchiseID,
       quantity
FROM workspace.session1_practice.bakehouse_transactions
WHERE transactionID % 10 = 0;

-- Look before you load
SELECT COUNT(*) AS rows FROM read_files('/Volumes/workspace/session1_practice/source_files/late/', format => 'csv', header => true);

SELECT franchiseID, COUNT(*) AS purchases
FROM read_files('/Volumes/workspace/session1_practice/source_files/late/', format => 'csv', header => true)
WHERE franchiseID NOT IN (SELECT franchiseID FROM read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_stores.csv', format => 'csv', header => true))
GROUP BY ALL;

-- Task 2 — append to bronze, re-run silver and gold (queries from the session)
INSERT INTO workspace.bronze.transactions
SELECT *, _metadata.file_name AS source_file, current_timestamp() AS ingested_at
FROM read_files('/Volumes/workspace/session1_practice/source_files/late/', format => 'csv', header => true);

CREATE OR REPLACE TABLE workspace.silver.transactions
COMMENT 'One row per valid purchase, with clear column names'
AS SELECT CAST(transactionID AS BIGINT) AS transaction_id,
          CAST(customerID AS BIGINT)    AS customer_id,
          CAST(franchiseID AS BIGINT)   AS store_id,
          CAST(quantity AS INT)         AS quantity
   FROM workspace.bronze.transactions
   WHERE quantity > 0;

CREATE OR REPLACE TABLE workspace.gold.sales
COMMENT 'Bakehouse sales: one row per purchase with store name, city and country'
AS SELECT t.transaction_id, t.customer_id, t.store_id, t.quantity,
          s.name AS store_name, s.city AS store_city, s.country AS store_country
   FROM workspace.silver.transactions t
   JOIN read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_stores.csv', format => 'csv', header => true) s
     ON t.store_id = s.franchiseID;

-- Follow the numbers: gold is short — the inner JOIN silently drops the unknown store
SELECT (SELECT COUNT(*) FROM workspace.bronze.transactions)       AS bronze,
       (SELECT COUNT(*) FROM workspace.silver.transactions)       AS silver,
       (SELECT COUNT(*) FROM workspace.gold.sales)                AS gold,
       (SELECT SUM(quantity) FROM workspace.silver.transactions)  AS silver_units,
       (SELECT SUM(quantity) FROM workspace.gold.sales)           AS gold_units;

-- Task 3 — fix gold: LEFT JOIN keeps every purchase
CREATE OR REPLACE TABLE workspace.gold.sales
COMMENT 'Bakehouse sales: one row per purchase with store details. Unknown stores kept as "Unknown store".'
AS SELECT t.transaction_id, t.customer_id, t.store_id, t.quantity,
          COALESCE(s.name, 'Unknown store') AS store_name,
          COALESCE(s.city, 'Unknown')       AS store_city,
          COALESCE(s.country, 'Unknown')    AS store_country
   FROM workspace.silver.transactions t
   LEFT JOIN read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_stores.csv', format => 'csv', header => true) s
     ON t.store_id = s.franchiseID;

SELECT (SELECT SUM(quantity) FROM workspace.silver.transactions) AS silver_units,
       (SELECT SUM(quantity) FROM workspace.gold.sales)          AS gold_units;

-- Task 4 — metric view with Units per Customer (UI edit; SQL equivalent)
CREATE OR REPLACE VIEW workspace.gold.sales_metrics
WITH METRICS LANGUAGE YAML
COMMENT 'Bakehouse sales KPIs'
AS $$
version: 1.1
source: workspace.gold.sales
dimensions:
  - name: Store
    expr: store_name
    synonyms: ['franchise', 'branch']
  - name: City
    expr: store_city
  - name: Country
    expr: store_country
measures:
  - name: Units Sold
    expr: SUM(quantity)
    synonyms: ['units', 'items sold']
  - name: Purchases
    expr: COUNT(1)
  - name: Customers
    expr: COUNT(DISTINCT customer_id)
  - name: Units per Customer
    expr: ROUND(SUM(quantity) / COUNT(DISTINCT customer_id), 1)
$$;

SELECT Country, MEASURE(`Units Sold`) AS units, MEASURE(`Units per Customer`) AS units_per_customer
FROM workspace.gold.sales_metrics
GROUP BY ALL
ORDER BY units_per_customer DESC;

-- Bonus — time travel: units before the late file (pick the version from DESCRIBE HISTORY)
DESCRIBE HISTORY workspace.gold.sales;
SELECT SUM(quantity) AS units_v0 FROM workspace.gold.sales VERSION AS OF 0;
SELECT SUM(quantity) AS units_now FROM workspace.gold.sales;
