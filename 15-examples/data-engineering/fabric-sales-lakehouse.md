---
title: Worked Example - Governed Sales Lakehouse in Microsoft Fabric
description: End-to-end Fabric example covering ingestion, medallion transformation, semantic delivery, capacity, security, and recovery.
domain: Data Engineering
subdomain: Microsoft Fabric
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - microsoft-fabric
  - lakehouse
  - worked-example
related:
  - ../../03-data-engineering/microsoft-fabric/README.md
---

# Worked Example: Governed Sales Lakehouse in Microsoft Fabric

## Problem and Assumptions

A fictional retailer needs daily net-sales and return metrics by order date, channel, product, and region. The operational order API and daily return file remain authoritative. The example uses synthetic names and no tenant, capacity, endpoint, credential, or customer values.

## Architecture

```text
Order API + return file
 -> Fabric Data Factory ingestion
 -> bronze lakehouse: immutable dated batches + manifest
 -> notebook/pipeline -> silver Delta tables: typed, deduplicated, conformed
 -> gold warehouse/lakehouse: sales fact + date/product/channel/region dimensions
 -> semantic model -> governed Power BI report
```

Development, test, and production use separate workspaces. Production is assigned to a capacity with explicit ownership and monitoring. Git/deployment support is verified for each item; environment-specific connections and item identifiers are rebound and tested after deployment.

## Data Contract and Implementation

The fact grain is one accepted order line adjusted by linked returns. Source order-line ID is the durable merge key. Ingestion records batch/run ID, source update time, ingestion time, checksum/count, and disposition. Bronze is retained for replay. Silver rejects invalid keys/types, keeps the latest valid source version, and records late data. Gold measures are reconciled to accepted source totals by business date.

Tests cover schema, unique key, required relationships, price/quantity ranges, freshness, return-to-order linkage, duplicates, and net-sales reconciliation. The semantic model owns approved measures; row-level access is tested by persona rather than inferred from workspace membership.

## Operations and Failure

A missing return file marks the product degraded and blocks the dependent refresh. A rerun uses the same batch ID and idempotent merge. A capacity alert is diagnosed in the Capacity Metrics app at the affected timepoint; heavy engineering work is rescheduled or isolated before scaling. Recovery replays the approved bronze manifests, rebuilds silver/gold in order, refreshes the semantic model, and reconciles totals.

## Security and Governance

Groups receive least-privilege workspace roles; data and semantic permissions are separate. Workload identity is used where supported, and secrets stay in approved connection mechanisms. Product owner, classification, lineage, freshness/quality objectives, capacity attribution, deployment evidence, recovery test, retention, and support owner are cataloged. Any external sharing or export needs explicit review.

## Acceptance

Demonstrate duplicate and late input, missing file, schema change, test-stage deployment, permission denial, semantic total validation, capacity throttling diagnosis, replay, and recovery without manual deletion or embedded secrets.
