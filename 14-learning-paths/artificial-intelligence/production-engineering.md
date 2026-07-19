---
title: AI Production Engineering Learning Path
description: Central progression from AI workload framing to evaluated, secure, observable production operations.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Learning Path
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - ai-production-engineering
  - learning-path
related:
  - ../../06-artificial-intelligence/production-engineering/README.md
---

# AI Production Engineering Learning Path

| Stage | Focus | Practice artifact |
|---|---|---|
| 1. Purpose | Critical journey, value, affected people, risk, AI vs deterministic choice | Use-case and risk brief |
| 2. Boundaries | Model, prompt, retrieval, data, tools, state, identity, human role | Threat-aware architecture |
| 3. Evaluation | Representative data, criteria, human calibration, adversarial cases | Versioned evaluation suite |
| 4. Delivery | Dependency manifest, contracts, staged release, abort threshold, rollback | Nonproduction release evidence |
| 5. Operations | Traces, metrics, sampled evaluation, feedback, cost/capacity | Dashboard and runbook |
| 6. Governance | NIST AI RMF, privacy, security, provenance, approvals, incidents | Production-readiness decision |
| 7. Leadership | Portfolio tiers, platform standards, vendor lifecycle, economics, assurance | Operating roadmap and scorecard |

Read the [canonical production-engineering family](../../06-artificial-intelligence/production-engineering/README.md), then use the existing focused material for [RAG](../../06-artificial-intelligence/rag/README.md), [agents](../../06-artificial-intelligence/ai-agents/README.md), [evaluation](../../06-artificial-intelligence/model-evaluation/README.md), and [responsible AI](../../06-artificial-intelligence/responsible-ai/README.md).

Build the [grounded support assistant](../../15-examples/artificial-intelligence/grounded-support-assistant.md). Inject missing evidence, unauthorized content, prompt injection, a tool timeout, model regression, quota pressure, and a telemetry outage. Demonstrate containment, rollback, and an evaluation case for each relevant failure.

Completion means you can release and operate the entire AI application as a versioned workload, not merely call a model endpoint.
