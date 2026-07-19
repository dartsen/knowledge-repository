---
title: Worked Example - Resilient Customer-Update Integration
description: Vendor-neutral API and event example with idempotency, outbox, replay, reconciliation, and governance.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - integration
  - api
  - event-driven
related:
  - ../../01-enterprise-architecture/integration-architecture/README.md
---

# Worked Example: Resilient Customer-Update Integration

## Problem

A customer system owns contact preferences. A service desk must submit a change and an analytics consumer must learn that the accepted preference changed. Names and values are synthetic; no organization-specific endpoints or credentials are included.

## Architecture

```text
Service desk -> Preference API -> Local transaction: preference + outbox
                                      |
                                      v
                                Publisher -> Event broker -> Analytics consumer
```

The API requires workload/user authorization and an idempotency key representing the requested business operation. In one local transaction it updates the preference and writes an outbox record. A publisher sends a versioned `PreferenceChanged` event and records publication progress. The analytics consumer stores the event ID atomically with its update so broker redelivery is harmless.

## Contract Decisions

- The preference service is authoritative; analytics is eventually consistent.
- The API can return the stored result for a repeated idempotency key.
- Events include synthetic customer reference, preference type, new state, occurrence time, event/source/type/schema identifiers, and trace context—never a credential or unrelated profile data.
- Ordering is supported per customer key, not globally. The consumer also compares occurrence/version state to reject stale updates.
- Breaking schema change requires a new version and overlap window; additive optional fields remain compatible.

## Failure and Operations

If the API times out after commit, the caller queries by idempotency key. If publication fails, the outbox remains pending and alerts on age. Invalid consumer data goes to quarantine with safe diagnostics. Replay uses an approved event-ID manifest, throttling, and existing deduplication. Daily reconciliation compares authoritative changes, published receipts, and consumer checkpoints.

## Security and Governance

Separate identities receive only API invoke, outbox publish, or topic consume permissions. Transport and storage are encrypted. Payload and telemetry fields follow classification and retention decisions. Contract, SLO, owners, access, replay approvals, versions, and retirement are cataloged. A production-readiness test injects API timeout-after-commit, publisher outage, duplicate event, old version, poison payload, and consumer recovery.
