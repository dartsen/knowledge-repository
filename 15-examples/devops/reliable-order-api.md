---
title: Worked Example - Reliable and Observable Order API
description: End-to-end example combining SLOs, resilience, telemetry, incident operations, security, and recovery.
domain: DevOps
subdomain: Reliability Engineering and Observability
content_type: Example
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - reliability-example
  - observability-example
  - order-api
related:
  - ../../08-devops/reliability-engineering/README.md
  - ../../08-devops/observability/README.md
  - ../../14-learning-paths/devops/reliability-observability.md
---

# Worked Example - Reliable and Observable Order API

All names and targets are illustrative. A real service requires stakeholder-approved objectives and environment-specific validation.

## Problem and Assumptions

Retail clients submit an order and need a durable acceptance response within two seconds. Payment authorization is synchronous; fulfillment is asynchronous. Duplicate client submissions must not create duplicate orders. The service may temporarily accept orders while fulfillment is unavailable, but it must not accept an order when authorization cannot be confirmed.

## Critical Journey and Objectives

| Item | Illustrative decision |
|---|---|
| Good event | Valid authorized request returns one durable order ID within 2 seconds |
| Total event | Valid authorized requests reaching the service, excluding approved synthetic traffic |
| SLO | 99.9 percent good events over a rolling 28-day window |
| Recovery | RTO 60 minutes; RPO 5 minutes for order state |
| Degraded mode | Queue fulfillment; status shows `accepted-awaiting-fulfillment` |
| Fail-closed boundary | Payment authorization uncertainty rejects acceptance |

The error-budget policy requires release review at sustained burn and pauses nonsecurity production changes after exhaustion until the service is within policy.

## Architecture

```text
Client
  -> API gateway
  -> Order API -> payment provider
       | atomic order + outbox
       v
     order database
       -> outbox publisher -> fulfillment queue -> fulfillment worker
       -> status API

Telemetry -> OpenTelemetry Collector -> metric, log, and trace backends
External synthetic probe -> critical-journey SLI
```

## Implementation Decisions

- Client sends an idempotency key bound to authenticated client and request hash.
- Order and outbox record commit atomically; acceptance follows durable commit.
- Payment call has a deadline within the remaining two-second budget and no unsafe blind retry.
- Fulfillment messages carry stable order, message, correlation, type, source, and contract version.
- Worker deduplication and state transition are committed before acknowledgement.
- Progressive release compares good/total, p99 latency, payment errors, queue age, and saturation.

## Observability

- Metrics: good/total, latency histogram, error class, payment dependency, outbox age, queue age, worker completion, dedupe count, saturation.
- Logs: structured state transitions and classified failures; no payment token or address payload.
- Traces: gateway, API, payment, database, publisher, broker, and worker linked by W3C-compatible context.
- Business reconciliation: accepted orders equal terminal fulfillment plus known in-progress/quarantined orders.
- Telemetry pipeline: export drops, queue usage, ingestion lag, and backend health.

## Failure Modes and Recovery

| Failure | Behavior | Verification |
|---|---|---|
| Duplicate client request | return original order for matching key and hash | one durable order and one business effect |
| Payment timeout | reject acceptance as indeterminate; retain safe diagnostic state | no accepted order without authorization |
| Fulfillment unavailable | continue bounded acceptance; queue and page on age burn | backlog drains and reconciliation returns to zero |
| Bad worker release | stop rollout, restore compatible version, quarantine poison items | critical journey and completion recover |
| Region loss | execute approved data and traffic failover | observed RTO/RPO and business validation |
| Telemetry backend loss | workload continues with bounded local export; external probe remains | pipeline-loss alert and no workload outage |

## Security and Governance

Use workload identities, least privilege, separate replay permission, encrypted stores and transport, protected backups, reviewed contracts, signed/verified artifacts according to policy, audited production changes, and redacted telemetry. Replays require exact selection, idempotency evidence, rate limit, abort criteria, and reconciliation.

## Operational Ownership

Product owns objective and degraded-mode acceptance. Order engineering owns API and data. Payments owns its dependency contract. Fulfillment owns consumer behavior. Platform operations owns shared runtime and telemetry pipeline. Incident command owns coordinated recovery; security leads suspected unauthorized access.

## Validation Exercise

1. Load at steady, peak, and one-zone/failover capacity.
2. Inject payment latency, broker unavailability, duplicate delivery, poison message, and telemetry export failure.
3. Deploy a faulty worker canary and execute stop/restore.
4. Restore backup in an isolated environment and measure RTO/RPO.
5. Run a controlled replay and reconcile all accepted orders.
6. Verify no prohibited data appears in telemetry or test artifacts.

The example passes only when the user journey, business state, evidence, access, and temporary controls are all verified after recovery.
