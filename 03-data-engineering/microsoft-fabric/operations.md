---
title: Microsoft Fabric Operations Runbook
description: Operating model for Fabric data products, capacity, pipelines, quality, refresh, lifecycle, and recovery.
domain: Data Engineering
subdomain: Microsoft Fabric
content_type: Runbook
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - fabric-operations
  - capacity-management
  - data-observability
related:
  - README.md
  - troubleshooting.md
---

# Microsoft Fabric Operations Runbook

## Monitor by Layer

| Layer | Minimum evidence |
|---|---|
| Source/ingestion | Source availability, expected vs received batches/events/rows, delay, gateway/connection health |
| Processing | Job/run outcome, duration, retries, data scanned/written, checkpoint, rejected records |
| Data product | Freshness, volume, schema, quality rules, reconciliation, table maintenance |
| Semantic/consumption | Refresh outcome, model/query latency, correctness probes, usage, user-facing availability |
| Platform | Capacity utilization and throttling, storage, workspace/item state, deployment and activity events |

Use the current Microsoft Fabric Capacity Metrics app for capacity consumption and throttling analysis. Interpret capacity at the exact timepoint and workload/item level; smoothing and shared consumption mean a daily average can hide bursts and rejected operations.

## Daily Response

1. Identify product, workspace/item, environment, run/job/activity ID, capacity, source, and affected data window.
2. Stop unsafe publication or downstream refresh if quality or completeness is uncertain. Label the product stale or unavailable rather than serving silently incorrect data.
3. Classify source/connectivity, identity/access, schema/data, code, Fabric item/service, deployment/configuration, or capacity/throttling.
4. Mitigate with a bounded rerun, scale/schedule change, rollback, source repair, quarantine, or configuration correction. Do not overwrite the only recoverable copy.
5. Reconcile source, landed, transformed, and published counts/values; verify semantic results and downstream consumption before closure.

## Cadence

- Daily: failed/late runs, data freshness/quality, refresh, capacity/throttling, service health.
- Weekly: recurring failures, expensive operations, retry/reprocess, storage/file/table health, orphaned items.
- Monthly: capacity plan, cost attribution, access/ownership gaps, unsupported/manual deployments, usage/adoption.
- Quarterly: tenant/workspace settings, access, recovery exercise, Git/deployment support matrix, preview/lifecycle decisions, source and semantic contracts.

## Recovery

Create an approved reprocessing manifest with source range, product/table, code and schema version, expected side effects, and validation. Reprocess from the authoritative retained layer using idempotent writes, then reconcile and re-run dependent products in order. Record actual freshness loss, RTO/RPO, and capacity impact.
