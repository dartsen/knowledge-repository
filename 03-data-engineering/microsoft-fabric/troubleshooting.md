---
title: Microsoft Fabric Troubleshooting Guide
description: Diagnostic paths for Fabric access, paths, data, pipelines, semantic models, deployments, and capacity.
domain: Data Engineering
subdomain: Microsoft Fabric
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - fabric-troubleshooting
  - lakehouse
  - capacity
related:
  - README.md
  - operations.md
---

# Microsoft Fabric Troubleshooting Guide

## Evidence First

Capture timestamp/time zone, tenant/capacity/workspace/item and environment, user or workload identity, role and data permission path, activity/run/request ID, source/destination, code/item/schema version, table/file/semantic model, data window, recent deployment/configuration, capacity timepoint, and exact error with sensitive values removed.

| Symptom | Investigate | Response |
|---|---|---|
| Item/table/path not found | Workspace/lakehouse attachment, stable IDs vs renamed/deleted names, `Files`/`Tables` path, permission | Correct reference and attachment; avoid guessed path changes |
| Data late or missing | Source arrival, gateway/connection, schedule, watermark/checkpoint, rejected records | Stop publication; recover from retained source and reconcile |
| Duplicate/incorrect rows | Rerun semantics, merge key, late data, schema/type, overlapping window | Quarantine output; repair idempotent merge and replay manifest |
| Pipeline/notebook fails intermittently | Service health, throttling, token/connection, concurrency, transient dependency | Retry only classified transient faults; reduce burst or isolate capacity |
| SQL endpoint or metadata stale | Table registration/format, sync delay, unsupported change, permissions | Validate OneLake table first; use documented sync/recovery action |
| Semantic refresh/query fails | Upstream freshness, credentials, model binding, security, capacity, schema | Restore dependency/binding; validate measures and security after refresh |
| Git/deployment mismatch | Supported-item matrix, branch/workspace mapping, conflicts, environment configuration | Preserve diff; resolve in source and verify post-deploy bindings |
| Capacity throttles | Metrics-app timepoint, operation/item/workspace, background vs interactive load | Pause/reschedule expensive work, optimize, isolate, or scale from evidence |

## Diagnostic Order

Confirm user/data-product impact, then source and data contract, identity/access, item configuration, code/schema, capacity, and service health. Use the Capacity Metrics app rather than assuming every slow operation is a code problem. Treat a successful job as incomplete until data quality, reconciliation, and consumer results pass.

## Recovery Verification

Verify expected source and target counts, key aggregates, freshness, duplicates, quarantined rows, downstream product versions, semantic totals/security, capacity recovery, and no unreviewed manual drift. Document any data window that remains unavailable or uncertain.
