---
title: Worked Example - Resilient Partner Claims Integration
description: End-to-end partner integration example covering API acceptance, durable messaging, contracts, security, operations, and replay.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Example
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - integration-example
  - partner-api
  - messaging
related:
  - ../../01-enterprise-architecture/integration-architecture/README.md
  - ../../14-learning-paths/enterprise-architecture/integration-architecture.md
---

# Worked Example - Resilient Partner Claims Integration

The organizations and targets are fictitious. No endpoint, tenant, credential, or agreement represents a live environment.

## Problem and Assumptions

A partner submits claim notices through an API. The receiving organization must validate partner identity and contract, durably accept the notice, process it asynchronously into the claims system, publish status events, and reconcile every accepted notice. Partners retry after timeouts, so duplicates are expected.

## Architecture

```text
Partner -> API gateway -> intake API -> atomic notice + outbox
                                      -> intake database
Outbox publisher -> durable queue -> claims adapter -> claims system
Claims adapter -> status-event topic -> partner status consumer
Reconciliation job <-> intake database and claims system
```

## Contract Decisions

- HTTPS API described with a pinned OpenAPI version; message application described with a pinned AsyncAPI version.
- Partner operation ID plus authenticated partner ID defines idempotency scope.
- `202 Accepted` means durable intake, not completed claim creation.
- Status events use a stable event envelope and contain no unnecessary sensitive claim detail.
- Contract changes are backward compatible within the current major version; breaking changes use a migration window and consumer evidence.

## Implementation

1. Gateway validates certificate or approved client authentication, token issuer/audience/scope where applicable, payload size, rate, and route.
2. API validates schema and business prerequisites, then commits notice, idempotency record, and outbox atomically.
3. Publisher sends a stable message ID and records publication.
4. Adapter checks deduplication, applies the business operation, commits result, then acknowledges.
5. Terminal failures enter a restricted quarantine with category and original immutable evidence.
6. Reconciliation compares durable accepted notices to created, rejected, pending, and quarantined outcomes.

## Failure and Recovery

| Scenario | Expected behavior |
|---|---|
| Partner retries after lost response | matching request returns the original acceptance result |
| Claims system throttles | bounded retry with jitter; queue age and error-budget burn increase |
| Invalid contract version | reject before side effects with stable error and migration link |
| Poison notice | quarantine after bounded attempts; continue unrelated work |
| Adapter commits but acknowledgement fails | redelivery is deduplicated without a second claim |
| Contract defect affects a batch | pause affected consumer/version, correct, select exact items, replay under approval |

## Security and Governance

Use separate identities for API, publisher, consumer, and replay; least privilege; encrypted transport and storage; validated issuer/audience/scope; secret and certificate rotation; data minimization; restricted quarantine access; audited contract changes and replays; partner offboarding; and retention according to the data agreement.

## Operations

Monitor good/total acceptance, latency, authentication failures, publish delay, queue age, adapter completion, terminal failures, contract versions, certificate lifecycle, and reconciliation variance. The intake owner coordinates end-to-end incidents across gateway, claims, platform, and partner owners.

## Controlled Replay

Approve the exact partner, contract version, time range, and message IDs. Confirm root cause is corrected, dedupe retention covers the selection, claims capacity is sufficient, sensitive access is authorized, and abort thresholds are active. Preserve original items, record each replay attempt, and reconcile to zero unexplained outcomes.

## Validation

Test duplicate request, timeout after commit, revoked token, expired certificate, schema change, queue redelivery, claims throttling, poison item, partial outage, and reconciliation mismatch. Production approval requires successful correction and replay evidence, not only happy-path connectivity.
