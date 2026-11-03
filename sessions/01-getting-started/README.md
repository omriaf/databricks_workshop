# Session 1 — Getting Started with Databricks Free Edition

**From Sign-Up to Your First Query · 3 November 2026 · 45 minutes · Presented in Hebrew**

[← All sessions](../../README.md#sessions) · [Next: SQL Warehouses →](../02-sql/README.md)

Start from scratch: create a Free Edition account, tour the workspace and notebooks, navigate Unity Catalog, upload a dataset, and run your first query and chart.

No prior Databricks experience is required. The session is suitable for individuals, startups, teams, and organizations of every size. No real company data, credentials, or connection to an organizational system is needed.

## Workshop links

Use these links before and during the live workshop:

| Resource | Link |
|---|---|
| Create a Databricks Free Edition account | [Sign up for Free Edition](https://www.databricks.com/learn/free-edition) |
| Download the workshop CSV | [Download `bakehouse_suppliers.csv`](https://github.com/omriaf/databricks_workshop/releases/download/workshop-v1/bakehouse_suppliers.csv) |

The **Download** link downloads the CSV file. No GitHub account, Git installation, or clone is needed.

## Before the workshop

1. Create your Free Edition account.
2. Download `bakehouse_suppliers.csv` and keep it in an easy-to-find folder.
3. Use only the provided synthetic dataset during the exercise.

## What we will build

During the workshop, we will:

1. Tour the Databricks workspace, notebooks, and the **Learn** area.
2. Find the built-in business data under `samples.bakehouse`.
3. Upload the supplier CSV and create `workspace.default.bakehouse_suppliers`.
4. Find the table and its columns in Unity Catalog.
5. Preview the data in a notebook.
6. Run a business-oriented SQL query to count suppliers by continent.
7. Use Genie Code to generate the equivalent PySpark code and visualize the supplier distribution with a bar chart.
8. Upload the same CSV to a Volume and refresh the same table with a repeatable SQL load.

Use the catalog available in your workspace if its name differs from `workspace`.

## Demo notebooks

| Notebook | Use it for |
|---|---|
| [01 — Query suppliers](notebooks/01_query_suppliers.sql) | Preview the uploaded table, count suppliers by continent, ask Genie Code for PySpark, and create a chart. |
| [02 — Load suppliers from a Volume](notebooks/02_load_suppliers_from_volume.sql) | Refresh the same table from the CSV in a Volume, then verify the row count. |

Open each file above and select **Download raw file**. In your Databricks workspace, open **Workspace → Import**, choose **File**, and import the `.sql` file. The notebooks include Markdown explanations and Genie Code prompts.

Start with notebook **01** after uploading the CSV as a table. Before running **02**, create a managed Volume named `upload_files` under `workspace.default` in Catalog and upload the same CSV to it. If your catalog or schema name differs, update the table names and `/Volumes/...` path in the notebooks. The loading step replaces `bakehouse_suppliers` with the CSV contents each time it runs.

## After the workshop

Return to **Learn** in your workspace to continue practicing. Browse `samples.bakehouse` to explore the built-in business data.

## Additional practice

[Open the additional practice guide](additional-practice/README.md) — about 20 minutes.

Repeat the workflow with two more Bakehouse CSVs: upload the files, inspect your tables, and use **Genie Code** in a notebook to answer two business questions. Compare stores by units sold and by different purchasing customers, create a chart, and check why a returning customer must not be counted as a new person on each purchase row.

The guide includes the download links and all instructions. You do not need to write SQL yourself or bring company data.

Find the next session and its materials in the [series overview](../../README.md#sessions).

## About Databricks Free Edition

Databricks Free Edition is a no-cost environment for learning, experimentation, and prototyping with data and AI. It includes a ready-to-use workspace, serverless compute, default storage, notebooks, SQL, dashboards, pipelines, and many AI capabilities.

Free Edition is quota-limited and intended for non-commercial use. It does not include guaranteed support or an SLA, and some enterprise administration, security, networking, and compute capabilities are unavailable. If a usage quota is exceeded, compute can be paused until the quota resets; the workspace data and settings are not deleted.

## Learn more

These resources are optional enrichment and are not required to follow the live exercise:

| Topic | Official documentation |
|---|---|
| Free Edition overview | [What is Databricks Free Edition?](https://docs.databricks.com/aws/en/getting-started/free-edition) |
| Limits and fair usage | [Databricks Free Edition limitations](https://docs.databricks.com/aws/en/getting-started/free-edition-limitations) |
| Notebook quickstart | [Query and visualize data from a notebook](https://docs.databricks.com/aws/en/getting-started/quick-start) |
| Table quickstart | [Create your first table and grant privileges](https://docs.databricks.com/aws/en/getting-started/create-table) |

## Dataset

[`data/bakehouse_suppliers.csv`](data/bakehouse_suppliers.csv) contains 27 synthetic supplier records and 10 columns:

`supplierID`, `name`, `ingredient`, `continent`, `city`, `district`, `size`, `longitude`, `latitude`, `approved`

The file is an export of the Databricks built-in sample table `samples.bakehouse.sales_suppliers`, ordered by `supplierID`. It contains no organizational or customer data.
