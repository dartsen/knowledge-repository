# dbt-Friendly Analytics Patterns

## Model Responsibilities

| dbt Layer           | Typical Purpose                 |
| ------------------- | ------------------------------- |
| `source`            | Declare upstream objects        |
| `staging`           | Rename, cast, and standardize   |
| `intermediate`      | Reusable joins and calculations |
| `marts` / `curated` | Business-facing final models    |
| `reporting`         | KPI and dashboard aggregates    |

## Model Documentation

Document:

* purpose
* grain
* primary key
* source models
* business rules
* freshness
* owner
* downstream consumers

## Example Tests

```yaml
version: 2

models:
  - name: fact_automation_transaction
    description: >
      One row per automation transaction.

    columns:
      - name: automation_transaction_id
        description: Unique transaction identifier.
        tests:
          - not_null
          - unique

      - name: automation_name
        tests:
          - not_null

      - name: status
        tests:
          - not_null
          - accepted_values:
              values:
                - pending
                - processing
                - completed
                - failed
```

## Source Freshness

```yaml
sources:
  - name: automation
    schema: raw_automation

    freshness:
      warn_after:
        count: 6
        period: hour
      error_after:
        count: 12
        period: hour

    tables:
      - name: automation_transaction
        loaded_at_field: source_loaded_at
```

---

# Common Mistakes and Fixes

| Mistake                                  | Why It Is a Problem                    | Better Approach                         |
| ---------------------------------------- | -------------------------------------- | --------------------------------------- |
| `UPDATE` or `DELETE` without `WHERE`     | Changes the full table                 | Preview with `SELECT`; use transactions |
| Filtering aggregates in `WHERE`          | Aggregate does not yet exist           | Use `HAVING`                            |
| Comparing null with `=`                  | Returns unknown rather than true       | Use `IS NULL`                           |
| Using `DISTINCT` to hide duplicates      | Masks a join or grain problem          | Correct join cardinality                |
| Joining before defining grain            | Produces accidental row multiplication | Write the grain first                   |
| Using `SELECT *` in production           | Fragile and harder to optimize         | Select explicit columns                 |
| Filtering a left-joined table in `WHERE` | Can turn the join into an inner join   | Move condition to `ON` when appropriate |
| Averaging averages                       | Produces incorrect weighted results    | Recalculate from totals                 |
| Counting rows instead of entities        | Inflates KPIs                          | Use correct distinct business key       |
| Mixing timestamps and dates              | Creates missing or duplicate periods   | Standardize time grain                  |
| Using local time inconsistently          | Creates reporting boundary errors      | Define reporting timezone               |
| Hardcoding dates                         | Makes recurring workflows stale        | Use parameters or relative dates        |
| No deterministic order in `ROW_NUMBER()` | Latest-row result can vary             | Add tie-breaker columns                 |
| Ignoring late-arriving data              | Incremental output becomes incomplete  | Use overlap or restatement logic        |
| Treating missing as zero                 | Changes business meaning               | Define null handling explicitly         |
| Building one massive query               | Difficult to test and maintain         | Use staged CTEs or models               |

---

# Important Join Filtering Example

This query effectively behaves like an inner join:

```sql
SELECT
    c.customer_id,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed';
```

Customers without orders have `NULL` for `o.status` and are removed by `WHERE`.

To retain customers without completed orders:

```sql
SELECT
    c.customer_id,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
   AND o.status = 'completed';
```

---

# Analytics Red Flags

* A query has no documented grain.
* `DISTINCT` appears after several joins without explanation.
* A metric uses `COUNT(*)` when a business entity should be counted.
* A percentage has no documented denominator.
* A KPI excludes records without documenting the exclusion.
* An average is calculated from previously averaged data.
* A date trend omits periods with zero activity.
* An incremental process has no late-arriving-data strategy.
* A “latest record” query has no deterministic tie-breaker.
* A left join is followed by a right-table filter in `WHERE`.
* A model mixes source cleanup, reusable logic, and final filtering.
* A workflow depends on `SELECT *`.
* Test data contains real sensitive information.
* A business exception is counted as a system failure.
* A dashboard total cannot be reconciled to a source total.
* An automation-facing table contains multiple rows per transaction without documenting why.

---

# Analytics Validation Checklist

Before publishing a result:

## Business Definition

* [ ] Business question is documented.
* [ ] Metric definitions are documented.
* [ ] Numerators and denominators are clear.
* [ ] Exclusions are documented.
* [ ] Timezone and reporting period are defined.

## Grain

* [ ] One-row meaning is documented.
* [ ] Business key is identified.
* [ ] Duplicate test is complete.
* [ ] Aggregation matches the expected grain.

## Joins

* [ ] Join relationship is understood.
* [ ] Row counts were checked before and after joins.
* [ ] Missing matches were reviewed.
* [ ] Many-to-many joins are intentional.
* [ ] Join keys use compatible data types.

## Data Quality

* [ ] Required values are not null.
* [ ] Accepted values are validated.
* [ ] Date logic is valid.
* [ ] Source and target totals reconcile.
* [ ] Late-arriving records are handled.

## Performance

* [ ] Filters are applied early.
* [ ] Only required columns are selected.
* [ ] Partition filters are used.
* [ ] Repeated large scans are minimized.
* [ ] Query plan was reviewed for large workloads.

## Consumption

* [ ] Column names are stable and clear.
* [ ] Freshness metadata is available.
* [ ] Sensitive data is appropriately protected.
* [ ] Downstream consumers are identified.
* [ ] Failure and exception behavior is documented.

---

# Quick SQL Review Checklist

```text
1. What is one row?
2. What is the business key?
3. Which records are in scope?
4. Could any join multiply rows?
5. Are nulls handled intentionally?
6. Are calculations performed at the correct grain?
7. Is the denominator correct?
8. Are dates and timezones handled consistently?
9. Can totals be reconciled?
10. Can the query run efficiently at production volume?
```

---

# Beginner-to-Pro Learning Path

| Level                         | Focus                                                  | Practical Outcome                       |
| ----------------------------- | ------------------------------------------------------ | --------------------------------------- |
| Beginner                      | `SELECT`, `WHERE`, `ORDER BY`, aliases                 | Retrieve and filter data                |
| Advanced Beginner             | Joins, `GROUP BY`, aggregation, `HAVING`               | Build basic summaries                   |
| Intermediate Practitioner     | CTEs, subqueries, window functions                     | Build readable multi-step analysis      |
| Analytics Practitioner        | KPIs, trends, funnels, cohorts, segmentation           | Answer business questions reliably      |
| Advanced Practitioner         | Query plans, partitioning, incremental logic           | Improve performance and scalability     |
| Data Engineering Professional | Data quality, contracts, dimensional models, dbt       | Build reusable governed data products   |
| Enterprise Professional       | Security, lineage, SLAs, observability, governance     | Operate analytics reliably              |
| Architect / Strategic Lead    | Platform strategy, modeling standards, workload design | Guide enterprise analytics architecture |

---

# Final Mental Model

Use SQL analytics as a controlled transformation pipeline:

```text
Business Question
    ↓
Defined Grain
    ↓
Scoped Source Data
    ↓
Standardized Fields
    ↓
Intentional Joins
    ↓
Reusable Derivations
    ↓
Correct Aggregation
    ↓
Data-Quality Validation
    ↓
Stable Analytics or Automation Output
```

Remember:

> A query is not complete when it runs. It is complete when its grain is clear, its totals are validated, its logic is understandable, and its output can be used safely.
