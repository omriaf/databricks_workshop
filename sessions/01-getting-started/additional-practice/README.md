# Additional practice — Which Bakehouse stores are leading?

[← Session 1](../README.md) · **About 20 minutes**

Repeat the live-demo workflow with two new files: upload data, inspect your tables, ask business questions with **Genie Code**, and create a chart. Use AI to generate the SQL; your job is to explain what the results measure and check the answer against the data.

Use your own Databricks Free Edition workspace. No real company data, Git installation, or GitHub account is needed.

## 1. Download and upload the files — about 5 minutes

| Download | Contents | Table name to use |
|---|---|---|
| [Download `bakehouse_stores.csv`](https://github.com/omriaf/databricks_workshop/releases/download/session1-practice-v1/bakehouse_stores.csv) | 48 stores: store ID, name, city, country | `bakehouse_stores` |
| [Download `bakehouse_transactions.csv`](https://github.com/omriaf/databricks_workshop/releases/download/session1-practice-v1/bakehouse_transactions.csv) | 3,333 purchase rows: purchase ID, customer ID, store ID, units | `bakehouse_transactions` |

These are direct file downloads. If your browser displays the CSV, use **Save As** and keep the `.csv` extension. You can also [browse the files here](data/).

1. Open your workspace. Choose **New → Add or upload data → Create or modify table / Upload files**; the wording may vary slightly.
2. Upload **one file at a time**, using the table names above. Keep the header row and inferred data types. The IDs and `quantity` should be whole numbers. Do not combine the two files into one table.
3. Choose the catalog and schema available to you, as in the demo. With `workspace` and `default`, the full names are `workspace.default.bakehouse_stores` and `workspace.default.bakehouse_transactions`.
4. In **Catalog**, open each table and check its columns and sample rows. Keep a note of both full table names; you will give them to Genie Code.

The store table uses `franchiseID` for the store ID. The same field appears in the purchase table and connects a purchase to a store. `quantity` means units purchased; it is not a monetary amount. Store names can repeat, so identify a store by its ID.

For this exercise, work with **your uploaded tables**. The built-in `samples.bakehouse` tables remain available for later exploration.

## 2. Question 1: Which five stores sold the most units? — about 5 minutes

Create a notebook and open **Genie Code**, the coding assistant inside the notebook. Ask it to generate SQL for this business question, using your two full table names:

> Which five stores sold the most units across all purchase rows in these tables? Show the store ID, store name, city, and total units. Keep different stores separate even when their names match. If stores tie, put the smaller store ID first. Explain how you connected the two tables and calculated the total.

Review the proposed table names, then run the SQL in a notebook cell. Ask Genie Code to explain anything you do not understand; you do not need to write the SQL yourself.

Create a **bar chart** from the result: store name as the category and total units as the value. Include the city or store ID in the label if names repeat.

Add a Markdown sentence naming the leading store and what the number represents. Does it tell you the store's revenue, or only the units sold?

## 3. Question 2: Which five stores served the most different customers? — about 5 minutes

**Before asking AI**, add your prediction in a Markdown cell:

> A customer appears in three purchase rows at the same store. How many customers should that person contribute to this store's customer count, and why?

Now ask Genie Code:

> Using the same uploaded tables, which five stores served the most different purchasing customers? Show the store ID, store name, city, and customer count. If stores tie, put the smaller store ID first. Explain what one counted customer represents.

Run the generated SQL. Compare the two top-five lists: is the leading store the same? Write one sentence describing the difference between the two rankings. These are two different measures of store performance; neither alone proves that a store is more profitable.

## 4. Check your understanding with actual data — about 5 minutes

Choose the **leading store from Question 1**. Give its store ID to Genie Code and ask it to:

1. Show the number of purchase rows and the number of different purchasing customers at that store, side by side.
2. Find one customer who appears in more than one purchase row at that store, and display that customer's purchase IDs and quantities.

Let AI calculate the counts; **no manual counting is required**. Inspect the example rows and write **1–2 sentences in your own words**: which count answers Question 2, and why can counting purchase rows produce a different answer? Refer to your selected store and customer ID as evidence.

## Your finished notebook

Keep the two business-query results, one bar chart, your prediction, and the short explanations in one notebook. Include the evidence queries from the understanding check. There is no need to submit or upload anything publicly.

If you get stuck, give Genie Code the exact full table names and error message. If it switches to `samples.bakehouse`, ask it to use your uploaded copies instead. You can also revisit **Learn** in your workspace or the [Session 1 learning links](../README.md#learn-more).

## About the data

Both files contain synthetic Databricks Bakehouse sample data. Only the columns needed for this exercise were exported; original column names and values were retained. Each file contains all source rows, ordered by its ID. No date filter was applied.

| File | Built-in source | Exported columns |
|---|---|---|
| `bakehouse_stores.csv` | `samples.bakehouse.sales_franchises` | `franchiseID`, `name`, `city`, `country` |
| `bakehouse_transactions.csv` | `samples.bakehouse.sales_transactions` | `transactionID`, `customerID`, `franchiseID`, `quantity` |

`transactionID` identifies a purchase row in this extract; do not assume that a row describes a complete shopping basket. No real organization or customer records are included. The downloadable files are a fixed snapshot, so the exercise stays reproducible even if the built-in samples change.
