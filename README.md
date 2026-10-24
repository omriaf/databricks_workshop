# Databricks Free Edition Workshop

## Session 1 — From sign-up to your first business insight

This repository contains the attendee materials for a Hebrew-language, hands-on introduction to Databricks Free Edition.

No prior Databricks experience is required. The session is suitable for individuals, startups, teams, and organizations of every size.

## Workshop links

Use these links before and during the live workshop:

| Resource | Link |
|---|---|
| Create a Databricks Free Edition account | [Sign up for Free Edition](https://www.databricks.com/learn/free-edition) |
| Download the workshop CSV | [Download `bakehouse_suppliers.csv`](https://github.com/omriaf/databricks_workshop/raw/refs/heads/main/data/bakehouse_suppliers.csv) |
| View the CSV in this repository | [`data/bakehouse_suppliers.csv`](data/bakehouse_suppliers.csv) |

If the CSV opens in the browser instead of downloading, save the page as `bakehouse_suppliers.csv`.

## Before the workshop

1. Create your Free Edition account.
2. Download `bakehouse_suppliers.csv` and keep it in an easy-to-find folder.
3. Use only the provided synthetic dataset during the exercise.

No real company data, customer data, credentials, or connection to an organizational system is needed.

## What we will build

During the workshop, we will:

1. Tour the Databricks workspace.
2. Upload the supplier CSV.
3. Create the governed table `workspace.default.bakehouse_suppliers`.
4. Find the table in Unity Catalog.
5. Preview the data in a notebook.
6. Run a business-oriented SQL query.
7. Visualize the supplier distribution by continent.

The later sessions in the series use the built-in `samples.bakehouse.*` tables, so they do not depend on the table created in this workshop.

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

You can also continue learning from the **Learn** section in your Databricks workspace.

## Dataset

`data/bakehouse_suppliers.csv` contains 27 synthetic supplier records and 10 columns:

`supplierID`, `name`, `ingredient`, `continent`, `city`, `district`, `size`, `longitude`, `latitude`, `approved`

The file is an export of the Databricks built-in sample table `samples.bakehouse.sales_suppliers`, ordered by `supplierID`. It contains no organizational or customer data.

Dataset provenance: [`glalanne/deltalink`](https://github.com/glalanne/deltalink), pinned source commit [`730d8cdc`](https://github.com/glalanne/deltalink/tree/730d8cdc053b8089aa3cc65b6f0246b4adcf768d), MIT licensed.

