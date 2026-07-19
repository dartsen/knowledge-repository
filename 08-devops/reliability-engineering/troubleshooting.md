---
title: Reliability Troubleshooting
description: Evidence-first investigation and recovery guide for service reliability failures.
domain: DevOps
subdomain: Reliability Engineering
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - troubleshooting
  - incident-response
  - production-diagnostics
related:
  - README.md
  - operations.md
  - ../observability/troubleshooting.md
---

# Reliability Troubleshooting

## First Ten Minutes

1. Confirm the affected user journey, geography, tenant or segment, and start time.
2. Compare current SLI and error-budget burn with the objective; do not rely on host health alone.
3. Identify recent deployments, configuration, data, identity, network, and dependency changes.
4. Assign incident command and a communication owner when severity requires coordination.
5. Choose the safest containment: stop rollout, reduce traffic, shed optional work, fail over, or activate degraded mode.
6. Record commands, decisions, timestamps, and evidence while preserving sensitive-data controls.

## Symptom Matrix

| Symptom | Check | Common cause | Safe next action |
|---|---|---|---|
| Elevated latency | p50/p95/p99, saturation, queue age, dependency spans | resource exhaustion, lock contention, slow dependency | cap concurrency, shed load, isolate dependency |
| Elevated errors | error class, version, route, dependency | bad release, expired identity, contract break | stop rollout, restore compatible version or identity |
| Intermittent timeout | remaining deadline, retry count, connection pool | retry amplification, pool exhaustion, network fault | reduce retries, enforce budget, isolate traffic |
| Backlog growth | arrival/service rate, oldest item, poison count | insufficient consumers, blocked dependency, poison message | quarantine poison work, scale within downstream limits |
| Stale or missing data | source commit, lag, checkpoint, reconciliation | failed consumer, ordering, replication lag | pause unsafe reads/writes, replay from known checkpoint |
| Regional failure | provider health plus independent probes | zonal/region/network fault | execute approved failover and validate data behavior |
| Alert with no user impact | SLI, alert expression, maintenance/change | noisy proxy signal or wrong threshold | downgrade, fix routing/query, keep audit trail |

## Diagnostic Discipline

- Form a falsifiable hypothesis and name the evidence that would disprove it.
- Change one control at a time where possible.
- Prefer reversible mitigation before invasive repair.
- Do not restart repeatedly without capturing state and understanding recovery consequences.
- Do not replay messages until idempotency and the replay boundary are confirmed.
- Verify mitigation through the critical user journey and SLI, then watch for recurrence.

## Escalate Immediately When

There is potential data loss or corruption, unauthorized access, safety or regulatory impact, recovery would exceed the approved target, the rollback path is unsafe, or no owner can authorize the required action.

## Closeout

Record user impact, detection and recovery times, contributing conditions, what went well, control gaps, owned actions, and any objective or architecture change. Validate that temporary permissions, bypasses, scaling, traffic routing, and feature flags are returned to an approved state.
