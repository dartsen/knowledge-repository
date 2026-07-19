# CTEs: Common Table Expressions

CTEs help divide a query into named steps.

```sql
WITH recent_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        amount
    FROM orders
    WHERE order_date >= DATE '2026-01-01'
),

by_customer AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(amount) AS total_amount
    FROM recent_orders
    GROUP BY customer_id
)

SELECT
    customer_id,
    order_count,
    total_amount
FROM by_customer
WHERE total_amount > 1000;
```

## Good CTE Responsibilities

Use separate CTEs for:

* source selection
* filtering
* standardization
* deduplication
* joins
* derivations
* aggregation
* validation
* final output

Avoid deeply nested queries when named steps would make the logic clearer.

---

# Window Functions

Window functions calculate across related rows without collapsing them.

```sql
SELECT
    customer_id,
    order_date,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_sequence,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    LAG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_amount,
    RANK() OVER (
        PARTITION BY customer_id
        ORDER BY amount DESC
    ) AS amount_rank
FROM orders;
```

| Function         | Use                          |
| ---------------- | ---------------------------- |
| `ROW_NUMBER()`   | Unique sequence              |
| `RANK()`         | Ranking with gaps after ties |
| `DENSE_RANK()`   | Ranking without gaps         |
| `LAG()`          | Previous row value           |
| `LEAD()`         | Next row value               |
| `FIRST_VALUE()`  | First value in a window      |
| `LAST_VALUE()`   | Last value in a window       |
| `SUM() OVER`     | Running or partition total   |
| `AVG() OVER`     | Moving or partition average  |
| `NTILE(n)`       | Split rows into buckets      |
| `PERCENT_RANK()` | Relative rank from 0 to 1    |

## Latest Row per Business Key

```sql
WITH ranked AS (
    SELECT
        policy_id,
        policy_version,
        updated_at,
        status,
        ROW_NUMBER() OVER (
            PARTITION BY policy_id
            ORDER BY updated_at DESC, policy_version DESC
        ) AS row_number
    FROM policy_versions
)

SELECT
    policy_id,
    policy_version,
    updated_at,
    status
FROM ranked
WHERE row_number = 1;
```

## Databricks `QUALIFY`

```sql
SELECT
    policy_id,
    policy_version,
    updated_at,
    status
FROM policy_versions
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY policy_id
    ORDER BY updated_at DESC, policy_version DESC
) = 1;
```

## Running Total

```sql
SELECT
    transaction_date,
    amount,
    SUM(amount) OVER (
        ORDER BY transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions;
```

## Rolling Seven-Day Average

```sql
SELECT
    activity_date,
    daily_count,
    AVG(daily_count) OVER (
        ORDER BY activity_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7_day_average
FROM daily_activity;
```

---

# Date and Time Analytics

## Common Date Operations

```sql
SELECT
    CURRENT_DATE AS today,
    DATE_TRUNC('month', CURRENT_DATE) AS month_start,
    DATE_TRUNC('year', CURRENT_DATE) AS year_start;
```

## Extract Date Parts

```sql
SELECT
    EXTRACT(YEAR FROM transaction_date) AS transaction_year,
    EXTRACT(MONTH FROM transaction_date) AS transaction_month,
    EXTRACT(DAY FROM transaction_date) AS transaction_day
FROM transactions;
```

## Monthly Trend

```sql
SELECT
    DATE_TRUNC('month', transaction_date) AS month_start,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY
    DATE_TRUNC('month', transaction_date)
ORDER BY
    month_start;
```

## Month-Over-Month Change

```sql
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS month_start,
        SUM(amount) AS total_amount
    FROM transactions
    GROUP BY
        DATE_TRUNC('month', transaction_date)
),

compared AS (
    SELECT
        month_start,
        total_amount,
        LAG(total_amount) OVER (
            ORDER BY month_start
        ) AS previous_month_amount
    FROM monthly
)

SELECT
    month_start,
    total_amount,
    previous_month_amount,
    total_amount - previous_month_amount AS amount_change,
    100.0 * (
        total_amount - previous_month_amount
    ) / NULLIF(previous_month_amount, 0) AS pct_change
FROM compared
ORDER BY
    month_start;
```

## Year-Over-Year Comparison

```sql
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS month_start,
        SUM(amount) AS total_amount
    FROM transactions
    GROUP BY
        DATE_TRUNC('month', transaction_date)
)

SELECT
    month_start,
    total_amount,
    LAG(total_amount, 12) OVER (
        ORDER BY month_start
    ) AS prior_year_amount,
    100.0 * (
        total_amount
        - LAG(total_amount, 12) OVER (ORDER BY month_start)
    ) / NULLIF(
        LAG(total_amount, 12) OVER (ORDER BY month_start),
        0
    ) AS year_over_year_pct
FROM monthly
ORDER BY
    month_start;
```

## Date Spine Concept

A date spine is a complete series of dates used to prevent missing days or months from disappearing from a report.

```sql
WITH date_spine AS (
    SELECT EXPLODE(
        SEQUENCE(
            DATE '2026-01-01',
            DATE '2026-12-31',
            INTERVAL 1 DAY
        )
    ) AS calendar_date
),

daily_activity AS (
    SELECT
        CAST(created_at AS DATE) AS activity_date,
        COUNT(*) AS activity_count
    FROM automation_transactions
    GROUP BY
        CAST(created_at AS DATE)
)

SELECT
    d.calendar_date,
    COALESCE(a.activity_count, 0) AS activity_count
FROM date_spine d
LEFT JOIN daily_activity a
    ON d.calendar_date = a.activity_date
ORDER BY
    d.calendar_date;
```

`EXPLODE(SEQUENCE())` is a Databricks/Spark SQL pattern.

---
