---
title: Worked Example - Reliable Order-Status Service
description: Vendor-neutral example joining service objectives, resilience, telemetry, operations, and governance.
domain: DevOps
subdomain: Reliability and Observability
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - reliability
  - observability
  - worked-example
related:
  - ../../08-devops/reliability-engineering/README.md
---

# Worked Example: Reliable Order-Status Service

## Problem and Assumptions

A customer portal reads order status from an API backed by an operational store and a slower carrier dependency. Values are illustrative, not promises. The critical flow is an authenticated user receiving a current order state for a valid order.

## Architecture

```text
Portal -> API gateway -> Order-status service -> Operational store
                                |
                                +-> Carrier adapter -> External carrier
                                +-> Telemetry pipeline -> Approved backend
```

The carrier call has a deadline, bounded retry for classified transient failures, circuit breaker, and cached last-known status labeled with its age. Reads do not block on telemetry export. A correlation ID crosses each boundary; secrets and customer data are excluded from telemetry attributes.

## Objective and Implementation

The team proposes an SLI of valid requests returning a correct current or explicitly degraded response within the agreed latency threshold, divided by valid requests. Product, support, and engineering must approve the target and exclusions after baseline measurement. Instrument outcome, latency histogram, cache age, dependency result, circuit state, queue/backlog where applicable, region, and version.

Contract tests cover carrier responses. Failure tests inject timeouts, throttling, stale cache, store unavailability, and telemetry-backend loss. The release gate validates probes, SLI query, dashboard version segment, rollback, and no sensitive fixture values.

## Operations and Recovery

Fast objective burn pages the service owner. The responder confirms portal impact, segments by version and region, and rolls back a correlated release or opens degraded mode when carrier failures dominate. Recovery requires successful synthetic reads plus reconciliation of cache freshness and any deferred carrier refreshes.

## Security and Governance

The API authorizes order access at the resource boundary. Workload identities access stores and telemetry. Break-glass access is time-bound and audited. Objective/query changes use pull requests. Retention and customer-data exclusions are documented. Quarterly exercises record actual recovery time and any data divergence.

## Validation Questions

- Does the SLI count the user outcome rather than process uptime?
- Can duplicate or late carrier responses corrupt state?
- Does degraded mode remain truthful and authorized?
- Can responders distinguish dependency, capacity, change, and telemetry failure?
- Are objective, recovery, and retention claims backed by current test evidence?
