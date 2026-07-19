# Data Profiling

Profiling helps you understand a dataset before applying business logic.

## Basic Table Profile

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_customers,
    MIN(created_at) AS earliest_created_at,
    MAX(created_at) AS latest_created_at,
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount,
    AVG(amount) AS average_amount
FROM transactions;
```

## Column Completeness

```sql
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN email_address IS NULL THEN 1 ELSE 0 END) AS missing_email,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS missing_amount
FROM transactions;
```

## Value Distribution

```sql
SELECT
    status,
    COUNT(*) AS row_count,
    100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS percentage_of_rows
FROM transactions
GROUP BY
    status
ORDER BY
    row_count DESC;
```

## Duplicate Detection

```sql
SELECT
    transaction_id,
    COUNT(*) AS duplicate_count
FROM transactions
GROUP BY
    transaction_id
HAVING COUNT(*) > 1;
```

## Composite-Key Duplicate Detection

```sql
SELECT
    policy_id,
    policy_version,
    coverage_code,
    COUNT(*) AS duplicate_count
FROM policy_coverage
GROUP BY
    policy_id,
    policy_version,
    coverage_code
HAVING COUNT(*) > 1;
```

## Invalid Value Detection

```sql
SELECT
    status,
    COUNT(*) AS row_count
FROM transactions
WHERE status NOT IN (
    'pending',
    'processing',
    'completed',
    'failed'
)
   OR status IS NULL
GROUP BY
    status;
```

---

# Data Quality Checks

## Uniqueness

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS distinct_ids
FROM transactions;
```

Expected:

```text
total_rows = distinct_ids
```

## Not Null

```sql
SELECT *
FROM transactions
WHERE transaction_id IS NULL;
```

## Referential Integrity

```sql
SELECT
    t.customer_id,
    COUNT(*) AS orphaned_transactions
FROM transactions t
LEFT JOIN customers c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL
GROUP BY
    t.customer_id;
```

## Accepted Values

```sql
SELECT
    status,
    COUNT(*) AS row_count
FROM transactions
WHERE status NOT IN (
    'pending',
    'completed',
    'failed'
)
GROUP BY
    status;
```

## Valid Date Range

```sql
SELECT *
FROM policies
WHERE expiration_date < effective_date;
```

## Reconciliation

```sql
WITH source_total AS (
    SELECT
        COUNT(*) AS row_count,
        SUM(amount) AS total_amount
    FROM source.transactions
),

target_total AS (
    SELECT
        COUNT(*) AS row_count,
        SUM(amount) AS total_amount
    FROM analytics.transactions
)

SELECT
    s.row_count AS source_row_count,
    t.row_count AS target_row_count,
    s.total_amount AS source_total_amount,
    t.total_amount AS target_total_amount,
    t.row_count - s.row_count AS row_count_difference,
    t.total_amount - s.total_amount AS amount_difference
FROM source_total s
CROSS JOIN target_total t;
```

---

# Descriptive Analytics

Descriptive analytics answers:

> What happened?

## Summary Statistics

```sql
SELECT
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount,
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount,
    STDDEV(amount) AS amount_standard_deviation
FROM transactions;
```

## Percentiles

Databricks example:

```sql
SELECT
    PERCENTILE_APPROX(amount, 0.50) AS median_amount,
    PERCENTILE_APPROX(amount, 0.75) AS percentile_75,
    PERCENTILE_APPROX(amount, 0.90) AS percentile_90,
    PERCENTILE_APPROX(amount, 0.95) AS percentile_95
FROM transactions;
```

Percentiles are often more useful than averages when values are heavily skewed.

## Distribution by Band

```sql
SELECT
    CASE
        WHEN amount < 100 THEN '01. Under 100'
        WHEN amount < 500 THEN '02. 100–499'
        WHEN amount < 1000 THEN '03. 500–999'
        WHEN amount < 5000 THEN '04. 1,000–4,999'
        ELSE '05. 5,000+'
    END AS amount_band,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY
    CASE
        WHEN amount < 100 THEN '01. Under 100'
        WHEN amount < 500 THEN '02. 100–499'
        WHEN amount < 1000 THEN '03. 500–999'
        WHEN amount < 5000 THEN '04. 1,000–4,999'
        ELSE '05. 5,000+'
    END
ORDER BY
    amount_band;
```

---

# Diagnostic Analytics

Diagnostic analytics answers:

> Why did it happen?

## Failure Breakdown

```sql
SELECT
    error_category,
    COUNT(*) AS failure_count,
    100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS failure_percentage
FROM automation_transactions
WHERE status = 'failed'
GROUP BY
    error_category
ORDER BY
    failure_count DESC;
```

## Failure by Source System

```sql
SELECT
    source_system,
    error_category,
    COUNT(*) AS failure_count
FROM automation_transactions
WHERE status = 'failed'
GROUP BY
    source_system,
    error_category
ORDER BY
    failure_count DESC;
```

## Compare Successful and Failed Records

```sql
SELECT
    status,
    AVG(processing_seconds) AS average_processing_seconds,
    AVG(input_record_count) AS average_input_record_count,
    AVG(retry_count) AS average_retry_count
FROM automation_runs
GROUP BY
    status;
```

## Contribution Analysis

```sql
WITH by_category AS (
    SELECT
        error_category,
        COUNT(*) AS failure_count
    FROM automation_transactions
    WHERE status = 'failed'
    GROUP BY
        error_category
)

SELECT
    error_category,
    failure_count,
    100.0 * failure_count
        / SUM(failure_count) OVER () AS contribution_pct,
    100.0 * SUM(failure_count) OVER (
        ORDER BY failure_count DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) / SUM(failure_count) OVER () AS cumulative_contribution_pct
FROM by_category
ORDER BY
    failure_count DESC;
```

This supports Pareto-style analysis: identifying the small number of causes responsible for most failures.

---

# KPI Design

A useful KPI needs:

* clear business meaning
* defined numerator
* defined denominator
* defined grain
* defined time period
* documented exclusions
* target or threshold
* accountable owner

## KPI Definition Template

| Field       | Example                                  |
| ----------- | ---------------------------------------- |
| KPI         | Automation completion rate               |
| Purpose     | Measure successful processing            |
| Numerator   | Completed transactions                   |
| Denominator | All eligible attempted transactions      |
| Exclusions  | Test records and user-cancelled requests |
| Grain       | One row per day and automation           |
| Target      | At least 98%                             |
| Owner       | Intelligent Automation Operations        |

## Completion Rate

```sql
SELECT
    automation_name,
    COUNT(*) AS attempted_count,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_count,
    100.0
        * SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0) AS completion_rate_pct
FROM automation_transactions
WHERE is_test_record = FALSE
GROUP BY
    automation_name;
```

## Straight-Through Processing Rate

```sql
SELECT
    automation_name,
    100.0
        * SUM(
            CASE
                WHEN status = 'completed'
                 AND manual_intervention_required = FALSE
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0) AS straight_through_processing_pct
FROM automation_transactions
GROUP BY
    automation_name;
```

## Average Handling Time Saved

```sql
SELECT
    automation_name,
    SUM(successful_transactions) AS successful_transactions,
    SUM(successful_transactions * manual_minutes_per_transaction)
        / 60.0 AS estimated_hours_saved
FROM automation_value_metrics
GROUP BY
    automation_name;
```

Avoid presenting estimated time savings as measured savings unless the methodology supports that claim.

---

# Segmentation

Segmentation divides records into meaningful groups.

## Customer Segmentation

```sql
SELECT
    customer_id,
    annual_revenue,
    CASE
        WHEN annual_revenue >= 1000000 THEN 'enterprise'
        WHEN annual_revenue >= 100000 THEN 'mid-market'
        WHEN annual_revenue >= 10000 THEN 'small-business'
        ELSE 'micro'
    END AS revenue_segment
FROM customers;
```

## Quartile Segmentation

```sql
SELECT
    customer_id,
    total_revenue,
    NTILE(4) OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_quartile
FROM customer_revenue;
```

## Recency, Frequency, Monetary Pattern

```sql
WITH customer_metrics AS (
    SELECT
        customer_id,
        DATEDIFF(CURRENT_DATE, MAX(order_date)) AS recency_days,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(amount) AS monetary_value
    FROM orders
    GROUP BY
        customer_id
)

SELECT
    customer_id,
    recency_days,
    frequency,
    monetary_value,
    NTILE(5) OVER (
        ORDER BY recency_days DESC
    ) AS recency_score,
    NTILE(5) OVER (
        ORDER BY frequency
    ) AS frequency_score,
    NTILE(5) OVER (
        ORDER BY monetary_value
    ) AS monetary_score
FROM customer_metrics;
```

Dialect behavior for `DATEDIFF` varies. Validate argument order in your platform.

---

# Funnel Analysis

Funnels measure progression through ordered process stages.

Example:

```text
Request received
    ↓
Validated
    ↓
Processed
    ↓
Document generated
    ↓
Email sent
```

```sql
SELECT
    COUNT(DISTINCT CASE
        WHEN request_received_at IS NOT NULL
        THEN transaction_id
    END) AS requests_received,

    COUNT(DISTINCT CASE
        WHEN validation_completed_at IS NOT NULL
        THEN transaction_id
    END) AS validated,

    COUNT(DISTINCT CASE
        WHEN processing_completed_at IS NOT NULL
        THEN transaction_id
    END) AS processed,

    COUNT(DISTINCT CASE
        WHEN document_generated_at IS NOT NULL
        THEN transaction_id
    END) AS documents_generated,

    COUNT(DISTINCT CASE
        WHEN email_sent_at IS NOT NULL
        THEN transaction_id
    END) AS emails_sent

FROM automation_transactions;
```

## Stage Conversion

```sql
WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE
            WHEN request_received_at IS NOT NULL
            THEN transaction_id
        END) AS received,

        COUNT(DISTINCT CASE
            WHEN validation_completed_at IS NOT NULL
            THEN transaction_id
        END) AS validated,

        COUNT(DISTINCT CASE
            WHEN email_sent_at IS NOT NULL
            THEN transaction_id
        END) AS sent

    FROM automation_transactions
)

SELECT
    received,
    validated,
    sent,
    100.0 * validated / NULLIF(received, 0) AS received_to_validated_pct,
    100.0 * sent / NULLIF(validated, 0) AS validated_to_sent_pct,
    100.0 * sent / NULLIF(received, 0) AS end_to_end_conversion_pct
FROM funnel;
```

---

# Cohort Analysis

A cohort groups entities by a shared starting period.

Examples:

* customer signup month
* first purchase month
* first automation use month
* policy effective month

## Monthly Customer Cohort

```sql
WITH first_order AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM orders
    GROUP BY
        customer_id
),

customer_activity AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC('month', order_date) AS activity_month
    FROM orders
),

cohort_activity AS (
    SELECT
        f.cohort_month,
        a.activity_month,
        MONTHS_BETWEEN(
            a.activity_month,
            f.cohort_month
        ) AS months_since_start,
        COUNT(DISTINCT a.customer_id) AS active_customers
    FROM first_order f
    INNER JOIN customer_activity a
        ON f.customer_id = a.customer_id
    GROUP BY
        f.cohort_month,
        a.activity_month,
        MONTHS_BETWEEN(
            a.activity_month,
            f.cohort_month
        )
)

SELECT
    cohort_month,
    activity_month,
    months_since_start,
    active_customers
FROM cohort_activity
ORDER BY
    cohort_month,
    activity_month;
```

`MONTHS_BETWEEN` behavior is dialect-specific. For reporting, it may be safer to calculate an integer month index using year and month components.

---

# Retention Analysis

```sql
WITH first_activity AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(activity_date)) AS cohort_month
    FROM user_activity
    GROUP BY
        user_id
),

activity AS (
    SELECT DISTINCT
        user_id,
        DATE_TRUNC('month', activity_date) AS activity_month
    FROM user_activity
),

cohort_size AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_users
    FROM first_activity
    GROUP BY
        cohort_month
),

retained AS (
    SELECT
        f.cohort_month,
        a.activity_month,
        COUNT(DISTINCT a.user_id) AS retained_users
    FROM first_activity f
    INNER JOIN activity a
        ON f.user_id = a.user_id
    GROUP BY
        f.cohort_month,
        a.activity_month
)

SELECT
    r.cohort_month,
    r.activity_month,
    r.retained_users,
    c.cohort_users,
    100.0 * r.retained_users
        / NULLIF(c.cohort_users, 0) AS retention_pct
FROM retained r
INNER JOIN cohort_size c
    ON r.cohort_month = c.cohort_month
ORDER BY
    r.cohort_month,
    r.activity_month;
```

---
