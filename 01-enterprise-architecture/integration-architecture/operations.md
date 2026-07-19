---
title: Integration Engineering Operations
description: Operating model for integration health, dependencies, replay, reconciliation, and lifecycle.
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
  - ../../../08-devops/observability/operations.md
---

# Integration Engineering Operations

## Health Model

Measure completed business outcomes, not transport success alone. Combine API good/total and latency, message ingress and completion, oldest backlog age, retry and terminal-failure rate, consumer lag, batch completeness, reconciliation variance, dependency health, and contract-version use.

## Operational Ownership

Every integration has a producer owner, consumer owner, platform/transport owner, source-of-truth owner, security/data owner, and end-to-end support owner. Define support hours and escalation across team and supplier boundaries.

## Daily Operations

- Review failed and aging work by business impact.
- Check backlog age, capacity, quotas, and downstream throttling.
- Reconcile accepted requests or source records with completed outcomes.
- Confirm certificate, secret, token, and endpoint lifecycle warnings.
- Review recent contract, routing, policy, and dependency changes.

## Replay and Correction

Replay is a controlled production change. Require a defined selection boundary, idempotency evidence, destination readiness, rate limit, authorization, dry-run or preview when possible, monitoring, abort criteria, and reconciliation. Preserve the original failed item and create an auditable replay attempt.

When business state is wrong, correct it through an approved domain operation or compensating transaction. Avoid direct database edits that bypass validation and audit unless an emergency procedure explicitly governs them.

## Lifecycle

Maintain consumer inventory, current and deprecated versions, migration dates, traffic by version, certificate and secret expiry, dependency support status, and retirement evidence. A version is not retired until active consumers are migrated or an authorized exception is recorded.

## Capacity Review

Forecast arrival rate, payload size, connection and throughput quotas, peak fan-out, retry amplification, retention, backlog drain time, and recovery surge. Test capacity after material topology, consumer, or contract changes.
