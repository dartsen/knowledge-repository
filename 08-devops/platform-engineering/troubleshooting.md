---
title: Platform Engineering Troubleshooting
description: Troubleshooting guide for internal platform workflows, catalogs, policy, providers, and adoption.
domain: DevOps
subdomain: Platform Engineering
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - platform-troubleshooting
  - self-service
  - developer-portal
related:
  - README.md
  - operations.md
  - ../observability/troubleshooting.md
---

# Platform Engineering Troubleshooting

## Trace the User Journey

Use the platform request ID to follow portal or CLI, platform API, authorization, policy evaluation, desired-state record, orchestrator, provider API, generated source change, delivery pipeline, catalog registration, and verification. Identify the last durable successful step before retrying.

| Symptom | Likely cause | Evidence | Safe response |
|---|---|---|---|
| User cannot discover service/template | catalog ingestion, ownership, permission, search index | source metadata and processing status | fix source and reprocess; avoid manual shadow catalog |
| Provisioning stuck | provider timeout, lost callback, lock, quota | state machine, provider operation ID, age | reconcile provider state before retry |
| Duplicate environment | non-idempotent request or portal retry | request IDs and provider tags | stop new work, identify authoritative resource, reconcile |
| Policy denies valid request | stale context, rule/version mismatch | evaluated inputs, policy version, reason | fix rule or issue scoped exception with expiry |
| Template output changed unexpectedly | floating dependency/action/template | lockfiles, digests, template version | pin reviewed version and regenerate diff |
| Pipeline cannot deploy | identity, environment protection, artifact evidence | authorization and provenance logs | restore approved trust; do not bypass gate |
| Shared runtime noisy neighbor | missing quotas/limits or bad tenant boundary | resource and namespace usage | contain tenant, apply reviewed limits, reassess isolation |
| Portal works but generated service fails | ownership boundary or broken golden path | generated repo tests and runtime telemetry | reproduce from current template; platform owns template defect |
| Adoption stalls | workflow does not solve priority task or docs/support fail | user observation, completion funnel, support themes | return to discovery; do not mandate usage as a metric fix |

## Recovery Rules

- Reconcile before retrying a timed-out provider operation.
- Prefer declarative repair or a reviewed source change over direct console mutation.
- Preserve failed state and audit evidence.
- Bound replay and bulk remediation by provider quota and downstream capacity.
- Do not disable tenancy, signing, vulnerability, or authorization controls to clear a queue.

## Closeout

Verify the user outcome, desired and actual state, catalog and ownership, policy compliance, platform SLO, cost allocation, and cleanup of temporary access or exceptions. Add a test at the failed boundary and update the golden path or support boundary.
