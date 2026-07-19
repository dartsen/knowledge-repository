---
title: Reliability Implementation
description: Implementation practices for resilient code, safe delivery, and failure testing.
domain: DevOps
subdomain: Reliability Engineering
content_type: Implementation Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - resilience-patterns
  - testing
  - safe-delivery
related:
  - README.md
  - architecture.md
  - ../observability/implementation.md
---

# Reliability Implementation

## Delivery Sequence

1. Write the critical-journey SLI and target before the implementation is considered complete.
2. Define request, message, and data contracts, including compatibility rules.
3. Establish deadline propagation, bounded concurrency, and resource limits.
4. Implement validation, idempotency, timeouts, retry budgets, and degraded behavior.
5. Instrument business outcome, dependency calls, queue delay, saturation, and recovery actions.
6. Automate unit, contract, integration, load, security, and failure tests.
7. Deploy an immutable artifact progressively and evaluate user-impact signals.
8. Exercise rollback or roll-forward and update the runbook from evidence.

## Resilient Call Rules

- Every remote call has a timeout shorter than the remaining end-to-end deadline.
- Retries apply only to classified transient failures and use exponential backoff with jitter.
- A retry policy has maximum attempts, maximum elapsed time, and a workload-wide retry budget.
- Side-effecting operations use idempotency keys or another durable duplicate-suppression strategy.
- Circuit breakers expose state and do not conceal prolonged dependency failure.
- Concurrency limits and backpressure prevent one caller or dependency from exhausting shared resources.
- Errors retain a stable machine-readable category and a correlation identifier without exposing secrets.

## Safe Change

Use one build artifact across environments. Separate deployment from feature release when practical. Prefer backward-compatible database and contract changes: expand, migrate, observe, and only then contract. Validate canary or progressive releases against SLO-aligned signals, not just process health.

An automated rollback must be safe for the data transition. If rollback cannot restore consistency, document a tested roll-forward and recovery procedure before release.

## Test Matrix

| Test | Evidence required |
|---|---|
| Contract and compatibility | Old and new producers/consumers coexist as designed |
| Load and soak | Latency, error, saturation, queue-age, and resource trends at target and failover load |
| Dependency fault | Timeout, rejection, stale response, malformed response, throttling, and recovery |
| Infrastructure fault | Instance, zone, network path, and storage impairment where applicable |
| Data recovery | Restore meets observed RTO/RPO and passes business validation |
| Delivery failure | Canary halt, rollback/roll-forward, and alert routing work |
| Security failure | Expired identity, revoked permission, secret rotation, and unauthorized access fail safely |

Use production-like data shape and volume with synthetic or sanitized values. Do not copy production secrets or regulated data into lower environments.

## SLO-as-Code Minimum

Keep the SLI query, objective, window, exclusions, owner, dashboard link, alert policy, and error-budget response in version control or another auditable system. Test query behavior against known good and bad events. A silently empty denominator must fail validation.

## Completion Checklist

- Critical journey and objective are approved.
- All remote calls have deadlines and bounded resource use.
- Duplicate and out-of-order behavior is tested where applicable.
- Release evaluation uses user-impact signals.
- Recovery has been exercised, not merely documented.
- Runbook steps are executable by the on-call role.
