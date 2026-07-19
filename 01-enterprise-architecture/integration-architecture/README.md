---
title: Integration Engineering
description: Production guidance for governed APIs, messaging, events, files, and cross-system data exchange.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - integration-engineering
  - api-integration
  - event-driven-architecture
related:
  - ../README.md
  - ../../14-learning-paths/enterprise-architecture/integration-architecture.md
  - ../../15-examples/enterprise-architecture/customer-update-integration.md
---

# Integration Engineering

Integration engineering designs and operates the contracts and delivery mechanisms that let independently changing systems exchange requests, messages, events, and files safely. Integration architecture defines the boundaries and tradeoffs; engineering makes them executable and supportable.

## Start Here

1. [Architecture](architecture.md) - select interaction style, ownership, consistency, and failure boundaries.
2. [Implementation](implementation.md) - implement contracts, idempotency, retries, testing, and delivery controls.
3. [Operations](operations.md) - operate flows, queues, dependencies, replay, reconciliation, and lifecycle.
4. [Security and governance](security-governance.md) - govern identity, data, contracts, change, and evidence.
5. [Troubleshooting](troubleshooting.md) - diagnose API, message, event, and batch failures.
6. [Official references](official-references.md) - current primary specifications and architecture guidance.

Follow the centralized [integration architecture learning path](../../14-learning-paths/enterprise-architecture/integration-architecture.md), then apply the [resilient customer-update integration worked example](../../15-examples/enterprise-architecture/customer-update-integration.md).

The preserved [generated navigation](legacy-generated-readme.md) and [expanded draft reference guide](reference-guide.md) remain useful background but do not override these Active guides. The [implementation supplement](implementation-guide.md) and [replay and reconciliation runbook](operations-runbook.md) add focused detail to the canonical implementation and operations guides.

## Choose the Interaction Deliberately

| Need | Prefer | Avoid when |
|---|---|---|
| Immediate answer and bounded latency | Synchronous API or RPC | dependency cannot meet the caller deadline or offline work is acceptable |
| Durable work handoff and load leveling | Queue or command channel | caller truly requires completion before proceeding |
| One fact consumed independently by many systems | Published event or stream | the producer is actually directing one consumer to act |
| Large scheduled transfer or legacy boundary | Managed batch/file exchange | near-real-time outcome or record-level recovery is required |
| Shared analytical replication | Governed data pipeline or change feed | operational command semantics are being hidden as data movement |

Hybrid designs are normal, but each boundary needs one clear contract, delivery expectation, owner, and recovery path.

## Production Integration Contract

Record purpose, producer and consumers, schema, semantic meaning, version policy, authentication and authorization, data classification, delivery and ordering expectations, idempotency, timeout/retry behavior, capacity and quotas, observability, error ownership, replay/reconciliation, support hours, and deprecation dates.

Do not promise exactly-once business processing based only on a broker feature. Design for duplicate delivery and make the business effect idempotent where correctness requires it.

## Organization-Specific Adoption Notes

> **Scope: Organization-Specific.** Local system names, endpoints, gateway products, broker namespaces, owners, certificate details, support contacts, and partner agreements belong in Project Delivery. Public guidance should use fictitious names and secret-free placeholders.
