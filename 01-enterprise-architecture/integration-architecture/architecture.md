---
title: Integration Architecture and Design
description: Architecture method for interaction styles, contracts, consistency, failure handling, and integration boundaries.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Architecture Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - integration-architecture
  - messaging
  - api-design
related:
  - README.md
  - ../../08-devops/reliability-engineering/architecture.md
  - ../../08-devops/observability/architecture.md
---

# Integration Architecture and Design

## Design Sequence

```text
Business transaction and ownership
  -> source of truth and consistency need
  -> interaction semantics and contract
  -> identity, network, and data boundary
  -> delivery, ordering, capacity, and failure behavior
  -> observability, recovery, lifecycle, and support
```

Start with the business state transition. Name who is allowed to request it, which system owns the decision and record, which parties need facts about the result, and how a partial outcome is corrected.

## Interaction Semantics

- **Query:** asks for state without intending a business change.
- **Command:** asks one logical owner to perform an action; acceptance is not completion.
- **Event:** states a fact that already happened; publishers do not direct subscriber behavior.
- **Document/file:** transfers a dataset or business document under a manifest and reconciliation contract.

Do not label commands as events to gain decoupling. The distinction determines ownership, authorization, failure handling, and replay safety.

## Topology Tradeoffs

| Topology | Benefit | Risk | Required control |
|---|---|---|---|
| Direct API | simple request path | runtime and release coupling | deadline, version policy, consumer tests |
| Gateway-mediated API | common policy and discovery | gateway bottleneck or policy drift | redundant gateway, configuration as code, bypass policy |
| Queue | buffering and independent scaling | backlog, duplicates, poison messages | age/size SLO, DLQ, idempotency, replay runbook |
| Publish-subscribe | independent consumers | hidden fan-out and eventual consistency | catalog, schema compatibility, consumer ownership |
| Durable stream | replay and ordered partitions | partition hotspots and stateful consumers | key strategy, lag SLO, checkpoint/replay controls |
| Orchestrated process | visible multi-step state and compensation | central coordinator coupling | durable state, step idempotency, timeout/compensation |
| Choreography | team autonomy and loose coupling | unclear end-to-end state | business correlation, ownership map, reconciliation |

## Contracts and Evolution

Use OpenAPI for HTTP APIs and AsyncAPI for message-driven APIs where they fit. Use CloudEvents when a common event envelope improves interoperability. Pin the specification version used by tooling; a `latest` documentation URL is for discovery, not a reproducible build.

Classify changes as compatible or breaking for actual consumers. Test required fields, nullability, enum expansion, ordering assumptions, numeric range, default behavior, and unknown fields. Maintain a consumer inventory, migration window, deprecation notice, and retirement evidence.

## Consistency and Recovery

Avoid distributed transactions across independently owned systems unless the technology and operating model explicitly support them. Prefer local atomic state plus an outbox or durable publication record, idempotent consumers, compensating actions, and reconciliation.

For each step, define:

- stable operation/message/event identifier;
- deduplication scope and retention;
- ordering key and behavior for late or missing items;
- maximum attempts and terminal failure location;
- replay start/end boundary and authorization;
- authoritative state and reconciliation query.

## Nonfunctional Budget

Allocate end-to-end latency across gateways, services, brokers, transformations, and dependencies. Bound payload size, concurrency, connections, throughput, burst, retry amplification, backlog age, and downstream quotas. Design backpressure before scale is needed.

## Architecture Review Gate

Approve when semantics are unambiguous, source of truth and owners are named, contracts and versioning are testable, security follows data and trust boundaries, duplicates and partial failure are safe, capacity is bounded, and replay/reconciliation are operationally owned.
