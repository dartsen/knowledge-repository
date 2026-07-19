---
title: AI Production Architecture
description: Architecture method for AI application boundaries, grounding, tools, evaluation, observability, reliability, and change.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Architecture Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - ai-architecture
  - generative-ai
  - production-ai
related:
  - README.md
  - implementation.md
---

# AI Production Architecture

## Start with the Critical Journey

Define the user or process outcome, affected people, unacceptable results, response-time expectation, data classes, decision authority, recovery target, and measurable task success. Prefer deterministic rules, search, workflow, or conventional analytics when they satisfy the need with lower uncertainty and operating cost.

Classify each AI action:

- **Suggest** - a person decides and acts.
- **Draft** - the system prepares content that is reviewed before release.
- **Read** - the system retrieves authorized information without mutation.
- **Act with approval** - a person approves the exact proposed change.
- **Bounded autonomous action** - policy permits a narrow reversible action.

Higher consequence requires stronger evidence, approval, fallback, and audit.

## Logical Architecture

```text
Authenticated client
 -> policy, rate, and input boundary
 -> orchestrator with request/correlation identity
    -> retrieval: authorized sources -> index -> citations
    -> model gateway: approved model/version, timeout, quota, fallback
    -> tool gateway: schema validation, scoped identity, approval, idempotency
 -> output validation, grounding/safety policy, and user disclosure
 -> response or controlled action

Evaluation corpus + adversarial cases -> offline/continuous evaluators
Telemetry -> traces, metrics, protected samples -> alert and investigation
Version registry -> code, prompt, model, index, tools, policy, evaluator
```

## Explicit Boundaries

Separate instructions from untrusted user and retrieved content. Treat retrieved documents, model responses, tool output, and external metadata as untrusted data. A model never grants authorization; the application revalidates identity and policy at each data or tool boundary.

Keep business state in an authoritative system, not only in conversational context. Tool calls use constrained schemas, server-side validation, least privilege, idempotency, and durable outcome records. Do not expose broad administrative tools to a general-purpose prompt.

## Quality and Reliability

Define task-specific quality measures and service objectives for availability, latency, error, throughput, recovery, and cost. Create graceful modes: approved smaller model, retrieval-only results, queued processing, deterministic response, or clear unavailability. A fallback is acceptable only if evaluated for the same risk and disclosed where behavior changes.

Cache only when identity, source freshness, prompt/model version, and policy make reuse safe. Bound retries to avoid duplicate actions and multiplicative token cost.

## Change Model

A change to code, model/version, prompt, retrieval corpus/chunking/embedding/index, tool schema, evaluator, safety policy, or runtime configuration can alter behavior. Give each a version, dependency manifest, test evidence, staged release, comparison plan, owner, rollback, and expiration/review where applicable.
