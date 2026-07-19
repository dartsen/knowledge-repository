---
title: "Data Quality Quick Reference"
domain: "Data Engineering"
level: "Beginner to Pro"
status: "Phase 3 Draft"
last_updated: "2026-06-20"
tags:
  - data-engineering
  - data-quality
  - quick-reference
related:
  - ../
---

# Data Quality Quick Reference

## Plain-English Explanation

Data Quality is the discipline of checking whether data is accurate, complete, consistent, valid, timely, unique, and fit for its intended use.

## Simple Analogy

Think of data quality like inspecting materials before they enter production. Bad materials can still move through the factory, but they create defective products downstream.

## Common Flow

```text
Define Rules → Apply Tests → Log Results → Block / Warn / Allow → Remediate → Monitor Trends → Improve Sources
```

## Why It Matters

- Trusted Reporting
- Automation Reliability
- Reduced Rework
- Better Decision-Making
- Risk Reduction
- Operational Stability

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Completeness | Required values are present. | Missing values can break reports or automations. | policy_id is not null. |
| Uniqueness | Records are not duplicated unexpectedly. | Duplicates create double counting and incorrect actions. | One active version per policy. |
| Validity | Values match allowed formats or domains. | Invalid values cause logic failures. | status in active, cancelled, expired. |
| Consistency | Values agree across related data sets. | Conflicting data reduces trust. | Policy status matches latest transaction. |
| Timeliness | Data is available when needed. | Late data can break SLAs. | Daily automation table refreshed before bot run. |
| Accuracy | Data reflects the real-world business fact. | Incorrect data leads to wrong decisions. | Premium amount matches source of record. |
| Fitness for Use | Quality is judged against the use case. | Not all data needs the same standard. | Reporting tolerance differs from automated decisioning. |

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
