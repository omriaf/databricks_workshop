# Additional practice — A late file arrives

[← Session 2](../README.md) · **About 25 minutes** · No downloads needed

In the session you built three tables on the Session 1 files: `bronze.transactions` → `silver.transactions` → `gold.sales`, plus the `gold.sales_metrics` metric view. Now the store system sends one more file, and part of it is surprising. Your job: load it, find out where data goes missing, and fix it.

## Before you start

You need the session's end state: the three tables and the metric view. Missed the live session? Run sections 3 and 4 of `session2_demo.sql` (about 2 minutes).

## Task 1 — A late file lands (5 min)

Run this in the **SQL editor**. It writes a late purchases file into the landing zone, in a `late` folder:

```sql
INSERT OVERWRITE DIRECTORY '/Volumes/workspace/session1_practice/source_files/late'
USING CSV OPTIONS (header 'true')
SELECT transactionID + 10000 AS transactionID,
       customerID,
       IF(transactionID % 100 = 0, 3000048, franchiseID) AS franchiseID,
       quantity
FROM workspace.session1_practice.bakehouse_transactions
WHERE transactionID % 10 = 0;
```

Now **look before you load**. Query the folder directly with `read_files('/Volumes/workspace/session1_practice/source_files/late/', format => 'csv', header => true)`:

- How many rows does it have?
- Which `franchiseID` values in the file do **not** exist in the store list (`bakehouse_stores.csv`)? How many purchases do they have?

## Task 2 — Load it and follow the numbers (8 min)

1. Append the late file to bronze: `INSERT INTO workspace.bronze.transactions SELECT ...` with the same columns as the session's bronze query (`*`, `_metadata.file_name AS source_file`, `current_timestamp() AS ingested_at`).
2. Re-run the session's **silver** and **gold** queries.
3. Compare the number of purchases in bronze, silver and gold, and the total units in silver vs gold.

**Question:** gold has fewer purchases than silver, and nothing failed. Where did they go, and which line of the gold SQL is responsible?

## Task 3 — Fix gold (7 min)

Change the gold query so that **no purchase is lost**: a purchase from a store that is not (yet) in the store list must still count, under the store name `'Unknown store'`. Re-run it and check that silver and gold units now match.

> Hint: think about the difference between `JOIN` and `LEFT JOIN`, and use `COALESCE`.

**Think about it:** is showing `'Unknown store'` always the right answer? When would you rather stop the load?

## Task 4 — Teach the metric view something new (5 min)

In **Catalog** → `workspace.gold.sales_metrics` → **Edit**, add a measure **Units per Customer**: `SUM(quantity) / COUNT(DISTINCT customer_id)`.

Answer: **Which country has the most units per customer? Is it the country with the most units overall?**

Keep the metric view. In Session 3 we point Genie at it.

## Bonus — Time travel

`DESCRIBE HISTORY workspace.gold.sales` shows a version for every re-run. Query the table as it was **before** the late file, using `VERSION AS OF`, and compare the total units with today's version.

## What you practiced

Querying files directly · appending to bronze · following row counts through the layers · `JOIN` vs `LEFT JOIN` data loss · editing a metric view · Delta history and time travel

## Solution

[`solution/homework_SOLUTION.sql`](solution/homework_SOLUTION.sql) has the full solution. Try the tasks yourself first.
