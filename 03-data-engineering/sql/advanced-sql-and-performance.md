# Subqueries

## Scalar Subquery

```sql
SELECT
    customer_id,
    total_amount
FROM customer_totals
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM customer_totals
);
```

## Correlated Subquery

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.amount > 1000
);
```

Correlated subqueries can be useful, but review performance on large datasets.

---

# Set Operations

| Operation          | Meaning                                            |
| ------------------ | -------------------------------------------------- |
| `UNION`            | Combine and remove duplicates                      |
| `UNION ALL`        | Combine and retain duplicates                      |
| `INTERSECT`        | Return rows present in both queries                |
| `EXCEPT` / `MINUS` | Return rows from the first query not in the second |

## Prefer `UNION ALL` When Deduplication Is Not Required

```sql
SELECT customer_id, source_system
FROM source_a

UNION ALL

SELECT customer_id, source_system
FROM source_b;
```

`UNION` adds a deduplication step and may remove valid repeated rows.

## Compare Two Datasets

```sql
SELECT
    policy_id,
    status
FROM expected_results

EXCEPT

SELECT
    policy_id,
    status
FROM actual_results;
```

Run the reverse comparison as well to detect rows missing from either side.

---

# Modifying Data

| Statement                | Purpose                           |
| ------------------------ | --------------------------------- |
| `INSERT`                 | Add rows                          |
| `UPDATE`                 | Change existing rows              |
| `DELETE`                 | Remove selected rows              |
| `MERGE`                  | Insert or update based on a match |
| `TRUNCATE`               | Remove all rows from a table      |
| `CREATE TABLE AS SELECT` | Create a table from query output  |

## Preview Before Updating

```sql
SELECT *
FROM customers
WHERE status = 'inactive';
```

Then:

```sql
UPDATE customers
SET archive_flag = TRUE
WHERE status = 'inactive';
```

## Transaction Pattern

Where supported:

```sql
BEGIN;

UPDATE customers
SET status = 'inactive'
WHERE last_activity_date < DATE '2024-01-01';

SELECT COUNT(*)
FROM customers
WHERE status = 'inactive';

COMMIT;
```

Use `ROLLBACK` instead of `COMMIT` if validation fails.

Transaction behavior varies by database and operation.

---

# De-Duplication Patterns

## Keep Latest Record

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY business_key
            ORDER BY updated_at DESC
        ) AS row_number
    FROM source_table
)

SELECT *
FROM ranked
WHERE row_number = 1;
```

## Deterministic Tie-Breaking

Do not rely only on a timestamp if ties are possible.

```sql
ROW_NUMBER() OVER (
    PARTITION BY business_key
    ORDER BY
        updated_at DESC,
        source_sequence DESC,
        record_id DESC
) AS row_number
```

A deterministic order ensures the same record is selected each time.

---

# Safe Division and Percentage Calculations

```sql
SELECT
    completed_count * 1.0
        / NULLIF(total_count, 0) AS completion_rate
FROM metrics;
```

Percentage:

```sql
SELECT
    100.0 * completed_count
        / NULLIF(total_count, 0) AS completion_rate_pct
FROM metrics;
```

Use decimal literals such as `100.0` where needed to prevent integer division.

---

# Pivot-Style Analysis

## Conditional Aggregation

```sql
SELECT
    business_unit,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END) AS failed,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending
FROM automation_transactions
GROUP BY
    business_unit;
```

Conditional aggregation is portable and often easier to maintain than dialect-specific `PIVOT` syntax.

---

# Anomaly Detection Patterns

## Compare With Recent Average

```sql
WITH daily AS (
    SELECT
        CAST(created_at AS DATE) AS activity_date,
        COUNT(*) AS daily_count
    FROM transactions
    GROUP BY
        CAST(created_at AS DATE)
),

scored AS (
    SELECT
        activity_date,
        daily_count,
        AVG(daily_count) OVER (
            ORDER BY activity_date
            ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING
        ) AS previous_7_day_average
    FROM daily
)

SELECT
    activity_date,
    daily_count,
    previous_7_day_average,
    daily_count - previous_7_day_average AS difference
FROM scored
WHERE previous_7_day_average IS NOT NULL
  AND daily_count > previous_7_day_average * 1.5;
```

This is a simple threshold, not a formal statistical anomaly model.

## Z-Score Pattern

```sql
WITH statistics AS (
    SELECT
        AVG(amount) AS mean_amount,
        STDDEV(amount) AS standard_deviation
    FROM transactions
),

scored AS (
    SELECT
        t.transaction_id,
        t.amount,
        (t.amount - s.mean_amount)
            / NULLIF(s.standard_deviation, 0) AS z_score
    FROM transactions t
    CROSS JOIN statistics s
)

SELECT
    transaction_id,
    amount,
    z_score
FROM scored
WHERE ABS(z_score) >= 3;
```

A z-score threshold is most meaningful when the underlying distribution is reasonably compatible with the technique.

---

# Query Performance Basics

## General Practices

* Filter early.
* Select only required columns.
* Avoid repeated scans of the same large source.
* Aggregate before joining when appropriate.
* Join on compatible data types.
* Avoid functions on indexed or partition columns when they prevent pruning.
* Review many-to-many joins.
* Prefer `UNION ALL` when deduplication is unnecessary.
* Avoid `DISTINCT` as a repair for duplicate joins.
* Use partition filters.
* Inspect the query plan.
* Materialize expensive reusable transformations when justified.
* Keep statistics current where the platform requires them.

## Partition-Friendly Filter

Less efficient in some platforms:

```sql
WHERE YEAR(transaction_date) = 2026
```

Usually more pruning-friendly:

```sql
WHERE transaction_date >= DATE '2026-01-01'
  AND transaction_date <  DATE '2027-01-01'
```

## Avoid Implicit Type Conversion

Risky:

```sql
ON numeric_customer_id = text_customer_id
```

Better:

* standardize types upstream
* cast once in a preparation layer
* avoid repeated runtime conversion

## Review Query Plan

Common commands include:

```sql
EXPLAIN
SELECT ...;
```

or:

```sql
EXPLAIN PLAN FOR
SELECT ...;
```

Look for:

* full scans
* unexpected shuffles
* cartesian joins
* repeated scans
* large sorts
* poor join strategies
* filters applied late

---
