---
title: AI Production Security and Governance
description: Controls for AI data, prompts, retrieval, models, tools, monitoring, supply chain, and accountable use.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Security and Governance Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - ai-security
  - ai-governance
  - prompt-injection
related:
  - architecture.md
  - ../../09-security-governance/ai-governance/README.md
---

# AI Production Security and Governance

## Apply Risk Management Across the Lifecycle

Use the NIST AI RMF functions—Govern, Map, Measure, and Manage—to connect organizational accountability, context, measurement, and treatment. Record the use case, affected stakeholders, risk tier, intended and prohibited use, limitations, human role, data lineage, model/provider, evaluation evidence, monitoring, incident path, and retirement criteria.

## Threat and Control Boundaries

| Risk | Required design direction |
|---|---|
| Prompt injection or malicious retrieved content | Treat all content as untrusted; separate instructions; constrain tools; validate policy server-side |
| Sensitive data disclosure | Minimize inputs/context/logs; authorize retrieval per request; redact; control retention and provider data use |
| Excessive agency | Narrow tools and identity; exact schemas; approval for consequential actions; limits, idempotency, rollback |
| Insecure output handling | Validate and encode output; never execute generated code/queries/markup without a separate safe boundary |
| Model or dependency supply chain | Approve source/license; pin versions; scan packages/images; record model card/terms; monitor lifecycle changes |
| Data or knowledge poisoning | Govern source onboarding and ownership; provenance; review; integrity checks; reindex controls |
| Extraction, abuse, or denial of service | Authenticate; authorize; rate/usage limits; anomaly detection; bounded context/iterations; safe errors |
| Misleading or harmful output | Grounding, task-specific evaluation, content/safety controls, disclosure, escalation, human review |

Safety filters complement application controls; they do not prove factual correctness, authorization, or business suitability.

## Identity and Tools

Propagate user and workload identity only as needed. Retrieval must filter to content the caller can access. Each tool gets a least-privilege identity and explicit allowed operations; high-risk write tools require preview and approval of the exact target and change. Reauthorize at execution time because conversation state may be stale.

## Privacy and Intellectual Property

Document lawful purpose, input/source rights, geographic and subprocessors constraints, training/retention settings, access, deletion, and data-subject handling where applicable. Validate licenses and attribution for models, data, prompts, and generated artifacts. Do not use production conversations as training/evaluation data by default.

## Governance Gates

Require risk-proportionate architecture, security/privacy, responsible-AI, data, legal/procurement, accessibility, and operational-readiness evidence. Maintain an exception with owner, rationale, compensating control, expiry, and review. Pause or retire the system if it no longer meets its approved purpose or evidence threshold.
