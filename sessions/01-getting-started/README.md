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
| Preview the CSV in this repository | [`data/bakehouse_suppliers.csv`](../../data/bakehouse_suppliers.csv) |

The **Download** link downloads the CSV file; the preview link displays its contents. No GitHub account, Git installation, or clone is needed.

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
7. Visualize the supplier distribution with a bar chart.

Use the catalog available in your workspace if its name differs from `workspace`.

## After the workshop

Return to **Learn** in your workspace to continue practicing. Browse `samples.bakehouse` to explore the built-in business data.

The homework exercise is being prepared and will be added here.

[Session 2 — SQL Warehouses](../02-sql/README.md) uses the built-in sample tables, so it does not depend on the CSV or table created in this session.

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

[`data/bakehouse_suppliers.csv`](../../data/bakehouse_suppliers.csv) contains 27 synthetic supplier records and 10 columns:

`supplierID`, `name`, `ingredient`, `continent`, `city`, `district`, `size`, `longitude`, `latitude`, `approved`

The file is an export of the Databricks built-in sample table `samples.bakehouse.sales_suppliers`, ordered by `supplierID`. It contains no organizational or customer data.
