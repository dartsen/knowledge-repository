---
title: AI Production Engineering
description: Production guidance for reliable, evaluated, observable, secure, and cost-aware AI applications.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Overview
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - ai-production-engineering
  - genaiops
  - ai-observability
related:
  - architecture.md
  - ../model-evaluation/README.md
  - ../../14-learning-paths/artificial-intelligence/production-engineering.md
---

# AI Production Engineering

Production AI engineering treats the complete application as the release unit: deterministic code, model endpoint, prompts/instructions, retrieval data and index, tool contracts, policies, evaluators, infrastructure, and user experience. Model output is probabilistic, but delivery, access, evidence, and recovery must be engineered deliberately.

## Use This Family For

- Selecting AI only where its uncertainty is acceptable
- Designing model, prompt, retrieval, tool, state, and policy boundaries
- Creating representative evaluation sets and release quality gates
- Versioning AI dependencies and deploying changes safely
- Observing quality, safety, latency, reliability, usage, and cost
- Responding to regressions, provider changes, prompt injection, and incidents

## Lifecycle

```text
Business outcome and risk tier
 -> architecture and data/tool boundaries
 -> versioned implementation plus offline evaluation
 -> adversarial, security, performance, and recovery tests
 -> staged release with comparison and rollback
 -> production tracing, sampled evaluation, feedback, and incident learning
```

## Guide Map

1. [Architecture](architecture.md) - critical journeys, layers, dependencies, and failure design
2. [Implementation](implementation.md) - versioning, tests, evaluators, and safe delivery
3. [Operations](operations.md) - telemetry, evaluation, incidents, capacity, and change
4. [Security and governance](security-governance.md) - data, tool, model, and human-control boundaries
5. [Troubleshooting](troubleshooting.md) - quality, retrieval, tool, latency, cost, and telemetry failures
6. [Official references](official-references.md) - current primary standards and platform guidance

Follow the [central learning path](../../14-learning-paths/artificial-intelligence/production-engineering.md) and build the [grounded support assistant example](../../15-examples/artificial-intelligence/grounded-support-assistant.md).

## Boundaries

Use [model evaluation](../model-evaluation/README.md), [RAG](../rag/README.md), [AI agents](../ai-agents/README.md), and [responsible AI](../responsible-ai/README.md) for their deeper subjects. This family connects those practices into a supportable production workload.

## Definition of Done

A production AI workload has measurable task and service objectives, representative and adversarial evaluation evidence, versioned dependencies, least-privilege data and tools, safe failure behavior, end-to-end observability with protected telemetry, staged deployment and rollback, accountable owners, and a tested incident runbook.
