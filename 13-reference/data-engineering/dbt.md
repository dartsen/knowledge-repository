---
title: "dbt Quick Reference"
domain: "Data Engineering"
level: "Beginner to Pro"
status: "Phase 3 Draft"
last_updated: "2026-06-20"
tags:
  - data-engineering
  - dbt
  - quick-reference
related:
  - ../
---

# dbt Quick Reference

## Plain-English Explanation

dbt is a transformation framework that lets teams build modular SQL models, test data assumptions, document lineage, and manage analytics engineering workflows in version control.

## Simple Analogy

Think of dbt as a disciplined assembly line for SQL transformations. Instead of scattered one-off queries, each transformation becomes a documented, testable, reusable model.

## Common Flow

```text
Sources → Staging Models → Intermediate Models → Marts / Curated Models → Tests → Docs → Deployment
```

## Why It Matters

- Trusted Transformations
- Lineage Visibility
- Testing Discipline
- Faster Analytics Development
- Version-Controlled Logic
- Reusable Data Models

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Model | A SQL select statement that dbt builds into a table, view, or incremental model. | Models are the core transformation unit. | intermediate_policy_base.sql. |
| Source | A declared upstream table or dataset. | Clarifies raw dependencies. | raw_magic_policy declared as a source. |
| Ref | A dbt function for referencing another model. | Builds lineage and dependency order. | select * from {{ ref('intermediate_policy_base') }}. |
| Test | A rule that validates assumptions about data. | Protects downstream trust. | not_null, unique, accepted_values, relationships. |
| Documentation | Descriptions and metadata generated for models and columns. | Improves discoverability and onboarding. | dbt docs site showing lineage and column definitions. |
| Materialization | How dbt persists a model. | Controls performance and storage behavior. | view, table, incremental, ephemeral. |
| Seed | Static reference data loaded from CSV. | Useful for controlled lookup mappings. | industry-to-line-of-business mapping seed. |

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
