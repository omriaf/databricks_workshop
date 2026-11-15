-- =====================================================================
-- Webinar 2/6 — SQL Warehouses · the whole demo in one script
-- Run in: SQL Editor · Compute: Serverless Starter Warehouse
-- Run one statement at a time: cursor inside it, then Ctrl/Cmd + Enter
-- Builds on Session 1: the Bakehouse CSV files in /Volumes/workspace/session1_practice/source_files/
-- =====================================================================


-- =====================================================================
-- 0 · Setup — only if you don't already have the Session 1 files and tables
--   1) Run the two statements below
--   2) Catalog → workspace → session1_practice → source_files → Upload to this volume:
--      bakehouse_transactions.csv and bakehouse_stores.csv (the Session 1 downloads)
--   3) Run the two CREATE TABLE statements
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS workspace.session1_practice;
CREATE VOLUME IF NOT EXISTS workspace.session1_practice.source_files;

CREATE TABLE IF NOT EXISTS workspace.session1_practice.bakehouse_transactions
AS SELECT * EXCEPT (_rescued_data)
   FROM read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_transactions.csv', format => 'csv', header => true);

CREATE TABLE IF NOT EXISTS workspace.session1_practice.bakehouse_stores
AS SELECT * EXCEPT (_rescued_data)
   FROM read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_stores.csv', format => 'csv', header => true);


-- =====================================================================
-- 1 · Sample queries on the Session 1 tables
-- =====================================================================

SELECT * FROM workspace.session1_practice.bakehouse_transactions LIMIT 10;

-- Which stores sell the most units?
SELECT s.name, s.city, s.country, SUM(t.quantity) AS units
FROM workspace.session1_practice.bakehouse_transactions t
JOIN workspace.session1_practice.bakehouse_stores s ON t.franchiseID = s.franchiseID
GROUP BY ALL
ORDER BY units DESC
LIMIT 5;

-- Units and distinct customers by country
SELECT s.country, SUM(t.quantity) AS units, COUNT(DISTINCT t.customerID) AS customers
FROM workspace.session1_practice.bakehouse_transactions t
JOIN workspace.session1_practice.bakehouse_stores s ON t.franchiseID = s.franchiseID
GROUP BY ALL
ORDER BY units DESC;

-- UI tour: Catalog → workspace → session1_practice → bakehouse_transactions
--   Overview · Sample data · Details · Permissions · History · Lineage
-- Then: Query history (left bar) → open a query → duration, rows, "See query profile"


-- =====================================================================
-- 2 · An expensive query, and how Genie Code repairs it
-- Running total of units, written the old way (a self-join):
-- every purchase is joined to every earlier purchase.
-- =====================================================================

SELECT a.transactionID, a.quantity, SUM(b.quantity) AS running_units
FROM workspace.session1_practice.bakehouse_transactions a
JOIN workspace.session1_practice.bakehouse_transactions b ON b.transactionID <= a.transactionID
GROUP BY a.transactionID, a.quantity
ORDER BY a.transactionID;

-- Open the Query profile: a nested loop join that builds ~5.5 million row pairs for 3,333 rows.
-- Ask Genie Code (the assistant in the editor): "This query is slow. Rewrite it more efficiently."
-- It suggests a window function. Run it and open the Query profile again:

SELECT transactionID, quantity, SUM(quantity) OVER (ORDER BY transactionID) AS running_units
FROM workspace.session1_practice.bakehouse_transactions
ORDER BY transactionID;

-- >>> Slides: how the lakehouse works under the hood (Spark, files, medallion)


-- =====================================================================
-- 3 · The pipeline: three queries, one per layer
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS workspace.bronze;
CREATE SCHEMA IF NOT EXISTS workspace.silver;
CREATE SCHEMA IF NOT EXISTS workspace.gold;

-- The landing zone: the files from Session 1
LIST '/Volumes/workspace/session1_practice/source_files/';

-- BRONZE: load the purchases file as-is, plus where and when it came from
CREATE OR REPLACE TABLE workspace.bronze.transactions
COMMENT 'Raw purchases, loaded as-is from the Session 1 landing files'
AS SELECT *,
          _metadata.file_name AS source_file,
          current_timestamp() AS ingested_at
   FROM read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_transactions.csv',
                   format => 'csv', header => true);

-- SILVER: clear names and types, only valid purchases
CREATE OR REPLACE TABLE workspace.silver.transactions
COMMENT 'One row per valid purchase, with clear column names'
AS SELECT CAST(transactionID AS BIGINT) AS transaction_id,
          CAST(customerID AS BIGINT)    AS customer_id,
          CAST(franchiseID AS BIGINT)   AS store_id,
          CAST(quantity AS INT)         AS quantity
   FROM workspace.bronze.transactions
   WHERE quantity > 0;

-- GOLD: business-ready, each purchase with its store (the store list comes straight from its file)
CREATE OR REPLACE TABLE workspace.gold.sales
COMMENT 'Bakehouse sales: one row per purchase with store name, city and country'
AS SELECT t.transaction_id, t.customer_id, t.store_id, t.quantity,
          s.name AS store_name, s.city AS store_city, s.country AS store_country
   FROM workspace.silver.transactions t
   JOIN read_files('/Volumes/workspace/session1_practice/source_files/bakehouse_stores.csv',
                   format => 'csv', header => true) s
     ON t.store_id = s.franchiseID;

SELECT * FROM workspace.gold.sales LIMIT 10;


-- =====================================================================
-- 4 · METRIC VIEW — created live in the UI
-- Catalog → workspace → gold → sales → Create → Metric view
--   Name: sales_metrics
--   Dimensions: Store (store_name), City (store_city), Country (store_country)
--   Measures:   Units Sold = SUM(quantity) · Purchases = COUNT(1) · Customers = COUNT(DISTINCT customer_id)
-- Then query it:
-- =====================================================================

SELECT Country, MEASURE(`Units Sold`) AS units, MEASURE(Customers) AS customers
FROM workspace.gold.sales_metrics
GROUP BY ALL
ORDER BY units DESC;

-- Backup if the UI misbehaves live: the same metric view in SQL
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
$$;
