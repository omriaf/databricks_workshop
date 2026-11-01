# Additional practice — Which Bakehouse stores are leading?

[← Session 1](../README.md) · **About 20 minutes**

Use **Genie Code** to generate SQL. Focus on understanding the results and checking what they mean.

## Files

| Download | Contents | Table name |
|---|---|---|
| [Download `bakehouse_stores.csv`](https://github.com/omriaf/databricks_workshop/releases/download/session1-practice-v1/bakehouse_stores.csv) | 48 stores: ID, name, city, country | `bakehouse_stores` |
| [Download `bakehouse_transactions.csv`](https://github.com/omriaf/databricks_workshop/releases/download/session1-practice-v1/bakehouse_transactions.csv) | 3,333 purchase rows: purchase ID, customer ID, store ID, units | `bakehouse_transactions` |

Synthetic data from `samples.bakehouse.sales_franchises` and `samples.bakehouse.sales_transactions`, with original column names. No company data is needed.

## Business questions

1. **Which five stores sold the most units?** Show store ID, name, city, and total units. Create a bar chart. Does this result also tell you their revenue?
2. **Which five stores served the most different purchasing customers?** Show store ID, name, city, and customer count. Compare the leaders with Question 1: are they the same?

**Understanding check**

Before using AI for Question 2, write your prediction: **a customer appears in three purchase rows at one store — how many customers should they count as, and why?**

Then, for the leading store from Question 1, ask Genie Code to show:

- Purchase-row count and different-customer count, side by side.
- One returning customer's purchase IDs and quantities at that store.

Inspect the example and explain in **1–2 sentences** which count answers Question 2. Refer to the store and customer IDs as evidence. Let AI calculate; no manual counting is needed.

## Suggested approach

1. **Upload:** use **New → Add or upload data** to create a separate table from each CSV. Use the table names above and your available catalog/schema. Note both full table names, such as `workspace.default.bakehouse_stores`.
2. **Inspect:** open both tables in **Catalog**. `franchiseID` connects purchases to stores; `quantity` means units purchased. Check that IDs and quantities are whole numbers.
3. **Ask Genie Code:** create a notebook, provide your full table names, and ask it to generate and explain SQL. Use your uploaded tables and all purchase rows. Keep stores separate by ID; break ranking ties by smaller store ID.
4. **Run and explain:** review the SQL, run it, and create the chart from Question 1. Keep both results, the chart, your prediction, and the understanding-check evidence and explanation in the notebook.
