---
title: "Data Lineage Quick Reference"
domain: "Data Engineering"
level: "Beginner to Pro"
status: "Phase 3 Draft"
last_updated: "2026-06-20"
tags:
  - data-engineering
  - data-lineage
  - quick-reference
related:
  - ../
---

# Data Lineage Quick Reference

## Plain-English Explanation

Data Lineage shows where data comes from, how it changes, and where it is consumed downstream.

## Simple Analogy

Think of lineage as a package tracking number for data. It tells you where the data started, which stops it passed through, and who received it.

## Common Flow

```text
Source → Transformation → Intermediate Model → Curated Model → Report / Automation / AI → Impact Review
```

## Why It Matters

- Impact Analysis
- Data Trust
- Auditability
- Faster Troubleshooting
- Change Management
- Governed Consumption

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Upstream | The sources or processes feeding a data asset. | Helps identify where data originates. | raw policy source table. |
| Downstream | The reports, models, automations, or systems using a data asset. | Helps assess change impact. | Power BI dashboard and automation lookup table. |
| Transformation | Logic that changes data from one form to another. | Explains how values are derived. | coverage premium rolled up to policy premium. |
| Column-Level Lineage | Traceability for individual fields. | Useful for sensitive fields and metric definitions. | renewal_premium sourced from coverage rows. |
| Impact Analysis | Assessment of what will be affected by a change. | Reduces breaking changes. | Changing policy status logic impacts reports and bots. |
| Metadata | Information about data assets. | Improves discovery and governance. | Owner, description, refresh schedule, sensitivity. |

## Red Flags

- No data owner.
- No defined grain.
- No tests.
- No lineage.
- No documented refresh expectation.
- No monitoring.
- Broad access to sensitive data.
- Duplicate logic in multiple places.
- Downstream consumers are unknown.
- Business definitions are unclear.

## Questions to Ask

1. What business question or process does this support?
2. What is the source of truth?
3. What is the grain?
4. What data quality rules matter?
5. Who owns the data?
6. Who consumes the output?
7. What happens if the data is late or wrong?
8. How is access controlled?
9. How will this be monitored?
10. How will changes be communicated?

## Beginner-to-Pro Focus

| Level | Focus |
|---|---|
| Beginner | Understand the basic idea and vocabulary. |
| Advanced Beginner | Follow common workflows and identify inputs/outputs. |
| Intermediate Practitioner | Build or apply the concept in a real use case. |
| Advanced Practitioner | Design for quality, scale, reliability, and supportability. |
| Enterprise Professional | Govern, monitor, document, and standardize across teams. |
| Architect / Strategic Lead | Define strategy, reference patterns, and data operating models. |
