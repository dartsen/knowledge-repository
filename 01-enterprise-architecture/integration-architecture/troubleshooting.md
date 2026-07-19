---
title: Integration Engineering Troubleshooting
description: Evidence-first troubleshooting for API, message, event, and batch integrations.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - integration-troubleshooting
  - api-errors
  - message-recovery
related:
  - README.md
  - operations.md
  - ../../08-devops/observability/troubleshooting.md
---

# Integration Engineering Troubleshooting

## Triage

1. Identify the business operation, stable correlation/operation ID, producer, consumer, contract version, and time window.
2. Determine the last durable success: producer commit, gateway acceptance, broker enqueue, consumer commit, or target reconciliation.
3. Compare recent contract, identity, certificate, routing, quota, deployment, and dependency changes.
4. Contain without destroying evidence: stop unsafe rollout, pause a consumer, reduce ingress, or quarantine failed work.
5. Verify recovery with the source of truth and end-to-end business outcome.

| Symptom | Check | Likely cause | Safe action |
|---|---|---|---|
| API 401/403 | issuer, audience, scopes, clock, caller/resource | expired credential, wrong audience, revoked permission | restore approved identity config; do not bypass authorization |
| API 429/503 | quota, concurrency, dependency, retry count | overload or retry amplification | honor retry guidance, reduce concurrency, shed load |
| Timeout with eventual completion | deadline and operation ID | caller timed out after server commit | query operation status; retry only with idempotency key |
| Queue backlog | arrival/service rate, oldest age, consumer health | blocked dependency, insufficient capacity, poison item | quarantine poison item, scale within downstream quota |
| Duplicate business effect | message ID, dedupe record, commit order | non-idempotent consumer or acknowledgement gap | stop replay, reconcile, fix atomic boundary |
| Out-of-order state | partition key, sequence, retries | wrong key or concurrent consumers | isolate entity, reconcile authoritative state |
| Schema failure | producer version, validator, unknown fields | breaking change or strict consumer | restore compatible contract; coordinate migration |
| Missing batch records | manifest, checksum, counts, completion marker | partial transfer or premature processing | quarantine batch and request complete immutable resend |
| DLQ growth | failure category, age, contract and identity | persistent invalid data or dependency | correct root cause before controlled replay |

## Replay Guardrail

Never bulk replay because the transport is healthy again. Confirm root cause, select exact items, prove idempotency or compensation, throttle to safe capacity, monitor abort signals, and reconcile every outcome.

## Closeout

Record impact, failed boundary, root and contributing conditions, recovery, correction/replay evidence, contract or runbook changes, and owned prevention actions. Remove temporary bypasses, permissions, and routing changes.
