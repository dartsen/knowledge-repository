---
title: Integration Operations Runbook
description: Operational procedures for contract health, backlog, replay, reconciliation, and partner incidents.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Runbook
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - integration-operations
  - replay
  - reconciliation
related:
  - README.md
  - troubleshooting.md
---

# Integration Operations Runbook

## Monitor

Track accepted, completed, failed, quarantined, duplicate, and reconciled business operations; API latency/status/throttling; broker depth, oldest-message age, consumer lag, dead-letter growth, and partition skew; file arrival/freshness/count/checksum; dependency and credential/certificate expiry; schema/version mix; and telemetry gaps.

## Incident Triage

1. Identify business process, producer, consumer, contract version, first failure, affected time window, and missing/duplicate business outcomes.
2. Stop unsafe amplification: pause a consumer, disable an upstream schedule, open a circuit, or reduce concurrency when continued processing can corrupt state or overload a dependency.
3. Classify transport, authentication/authorization, throttling/capacity, schema/data, application, or dependency failure.
4. Mitigate with a reviewed change or known runbook action. Do not delete messages, files, or dead-letter items to make a metric green.
5. Reconcile the source of truth to receipts and downstream state before declaring recovery.

## Replay Procedure

Approve replay scope and business impact. Freeze or coordinate concurrent writes if required. Export an immutable manifest of operation IDs, original order/key, schema version, and reason. Test a small sample in a safe destination. Replay with throttling and idempotency enabled, observe completion and side effects, reconcile counts and values, then retain the replay record.

## Routine Cadence

- Daily: backlog age, dead-letter/quarantine, failed schedules, partner health.
- Weekly: recurring errors, retry volume, schema/version adoption, unresolved reconciliation.
- Monthly: capacity, retention, certificate/key and credential expiry, cost, SLA/SLO evidence.
- Quarterly: access, contract ownership, disaster/replay exercise, dependency and deprecation review.
