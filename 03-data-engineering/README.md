---
title: Data Engineering
description: Navigation for data architecture, platforms, modeling, quality, lineage, transformation, and operations.
domain: Data Engineering
subdomain: Domain Overview
content_type: Overview
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - data-engineering
  - data-architecture
  - lakehouse
related:
  - ../04-analytics-bi/README.md
  - ../09-security-governance/README.md
---

# Data Engineering

## Scope

Use this domain for data architecture, ingestion, storage, transformation, modeling, quality, lineage, orchestration, governed access, and platform operations.

## Recommended Starting Point

Learn data flow, grain, modeling, and quality before choosing platform-specific implementation patterns. Continue with SQL, Databricks, dbt, Microsoft Fabric, orchestration, lineage, and governance.

## Key Concepts

- Data products, contracts, ownership, and consumers
- Batch, streaming, and event-driven ingestion
- Lakehouse and medallion architecture
- Dimensional, relational, and semantic modeling
- Data quality, tests, observability, and lineage
- Incremental processing and orchestration
- Security, cataloging, retention, and cost

## Common Uses

- Design a governed data pipeline.
- Select a data model and declare its grain.
- Implement tests and quality gates.
- Compare Databricks, dbt, and Microsoft Fabric patterns.
- Diagnose late, incomplete, duplicated, or incorrect data.

## Platform and Pattern Guides

- [Microsoft Fabric](microsoft-fabric/README.md)
- [Databricks](databricks/README.md)
- [Databricks repeatable patterns](databricks/databricks-patterns.md)
- [dbt](dbt/README.md)
- [Data modeling patterns](data-modeling/modeling-patterns.md)
- [Data Quality](data-quality/README.md)
- [Data Lineage](data-lineage/README.md)

Confirm each linked guide's `status` before treating it as authoritative.

## Learning Sequence

```text
Data flow and grain → Modeling → SQL → Quality and testing
→ Platform implementation → Orchestration → Governance and operations
```

## Related Domains

- [Analytics and BI](../04-analytics-bi/README.md)
- [Artificial Intelligence](../06-artificial-intelligence/README.md)
- [Security and Governance](../09-security-governance/README.md)
