# Session 2 — SQL Warehouses

**Answer Business Questions with Fast, Serverless SQL · 17 November 2026 · 45 minutes · Presented in Hebrew**

[← All sessions](../../README.md#sessions) · [← Session 1](../01-getting-started/README.md) · [Next: Just Ask Genie →](../03-genie/README.md)

Coming from PostgreSQL or SQL Server? This session shows what is different in a lakehouse, and why. We run SQL on a serverless SQL Warehouse, look under the hood (a table is just files), and turn raw POS files into trusted **bronze → silver → gold** tables and business **metric views**. Those metric views are what Genie uses in Session 3.

No prior SQL Warehouse experience is required. Basic SQL (`SELECT`, `JOIN`, `GROUP BY`) helps.

## Workshop links

| Resource | Link |
|---|---|
| Your Free Edition workspace | [Sign in or sign up](https://www.databricks.com/learn/free-edition) |
| Session 1 files | [`bakehouse_transactions.csv`](https://github.com/omriaf/databricks_workshop/releases/download/session1-practice-v1/bakehouse_transactions.csv) · [`bakehouse_stores.csv`](https://github.com/omriaf/databricks_workshop/releases/download/session1-practice-v1/bakehouse_stores.csv) |
| Session script (one file) | [`sql/session2_demo.sql`](sql/session2_demo.sql) |
| Slides (PDF) | [`slides/session2_slides.pdf`](slides/session2_slides.pdf) |

## Session materials

| File | Use it for |
|---|---|
| [`sql/session2_demo.sql`](sql/session2_demo.sql) | The whole session in one SQL script: setup, sample queries, the expensive query and its fix, bronze → silver → gold, and the metric view. |
| [`slides/session2_slides.pdf`](slides/session2_slides.pdf) | The slides: how the lakehouse works under the hood, and what a metric view is. |
| [`additional-practice/README.md`](additional-practice/README.md) | Homework: a late file arrives. |
| [`additional-practice/solution/homework_SOLUTION.sql`](additional-practice/solution/homework_SOLUTION.sql) | Homework solution. Try it yourself first. |

To use the script, open the file above and select **Download raw file**. In your workspace, open **Workspace → Import**, choose **File**, and import `session2_demo.sql`. Open it in the **SQL editor** and attach the **Serverless Starter Warehouse**.

## Before the workshop

We continue from the Session 1 Bakehouse files. You need them in a volume in your workspace:

1. Sign in to your Free Edition workspace.
2. Open `session2_demo.sql` in the **SQL editor** and follow **Section 0**: it creates the schema `workspace.session1_practice` and the volume `source_files`, then tells you to upload the two Session 1 CSVs into the volume and create the two tables. About 3 minutes.

Already have them from Session 1's additional practice? Make sure the files are in `/Volumes/workspace/session1_practice/source_files/`, then run Section 0 anyway: it skips anything that already exists.

## What we will build

| Step | What you do |
|---|---|
| 1 · Sample queries | Query the Session 1 tables, and tour **Catalog** and **Query history** |
| 2 · An expensive query | Read its **Query Profile**, then let **Genie Code** rewrite it |
| 3 · Bronze | `workspace.bronze.transactions`: the purchases file, as it came |
| 4 · Silver | `workspace.silver.transactions`: clear names and types, valid rows only |
| 5 · Gold | `workspace.gold.sales`: every purchase with its store, city and country |
| 6 · Metric view | `workspace.gold.sales_metrics`: Units Sold, Purchases and Customers, created in the UI |

**Keep them.** Session 3 builds on them.

## Additional practice

[Open the additional practice guide](additional-practice/README.md) — about 25 minutes, no downloads.

A late purchases file arrives. Look at it before loading, append it to bronze, and follow the numbers through silver and gold to find where purchases silently disappear. Fix gold, then teach the metric view a new measure and answer: which country has the most units per customer?

## Learn more

These resources are optional enrichment:

| Topic | Official documentation |
|---|---|
| SQL warehouses | [What is a SQL warehouse?](https://docs.databricks.com/aws/en/compute/sql-warehouse/) |
| Query files directly | [`read_files` table-valued function](https://docs.databricks.com/aws/en/sql/language-manual/functions/read_files) |
| Window functions | [Window functions](https://docs.databricks.com/aws/en/sql/language-manual/sql-ref-window-functions) |
| Query Profile | [Query profile](https://docs.databricks.com/aws/en/sql/user/queries/query-profile) |
| Medallion architecture | [What is the medallion lakehouse architecture?](https://docs.databricks.com/aws/en/lakehouse/medallion) |
| Metric views | [Unity Catalog metric views](https://docs.databricks.com/aws/en/metric-views/) |

## Dataset

The Session 1 Bakehouse files: `bakehouse_transactions.csv` (3,333 purchases: purchase ID, customer ID, store ID, units) and `bakehouse_stores.csv` (48 stores: ID, name, city, country). Synthetic data derived from the Databricks built-in sample `samples.bakehouse`. No organizational or customer data is used.
