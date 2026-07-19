---
title: AI Production Troubleshooting
description: Diagnostic runbook for AI quality, grounding, retrieval, tools, latency, cost, capacity, and telemetry.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - ai-troubleshooting
  - ai-quality
  - genaiops
related:
  - operations.md
  - official-references.md
---

# AI Production Troubleshooting

## First Capture

Record request/correlation ID, UTC time, environment, release manifest, model deployment/resolved version, prompt, index/corpus, policy, tool and evaluator versions, input class and approximate size, user journey, expected/actual outcome, recent changes, and trace. Do not paste unredacted production prompts, retrieved content, personal data, credentials, or full model output into general tickets.

## Decision Table

| Symptom | Isolate | Safe response |
|---|---|---|
| Answer is unsupported | Source authority/freshness, retrieval results, citation mapping, instruction hierarchy | Suppress unsupported claim, use retrieval-only/escalation, add case to evaluation |
| Quality regressed | Release dimensions, segment, evaluator drift, model alias, prompt/index change | Halt rollout; compare one dependency at a time; restore compatible release set |
| Relevant source not found | Authorization filter, ingestion, chunking, metadata, embedding/index, query | Validate source eligibility and indexing before tuning generation |
| Unauthorized source appears | ACL synchronization, cache key, pre/post filter, shared index | Disable affected retrieval, preserve evidence, treat as security incident |
| Tool chose wrong action | Description/schema ambiguity, state, policy, approval, model behavior | Disable/narrow tool; require preview/approval; validate exact arguments server-side |
| Duplicate action | Retry/timeout, missing idempotency key, ambiguous tool result | Stop retry; query authoritative state; reconcile then add idempotency |
| Latency rose | Queue, model, context, retrieval fan-out, tool, streaming, retries | Trace critical path; bound work; degrade through evaluated fallback |
| Cost spiked | Traffic, tokens/context, agent loops, retry amplification, model/rate change | Cap loop/retry; verify usage and price basis; preserve quality gate before routing change |
| Safety/refusal shifted | Policy/filter/model version, locale/segment, evaluator | Contain release; review representative cases and provider change notes |
| Traces are missing | Instrumentation, sampling, propagation, exporter/backpressure, redaction failure | Use local safe telemetry; repair pipeline; never disable privacy controls to gain visibility |
| Provider rate limit/outage | Quota, regional health, concurrency, retry storm | Shed/queue load, honor backoff, use evaluated fallback, avoid synchronized retries |

## Differential Diagnosis

Replay an approved failing case against the prior and current release. Hold all but one dependency constant: prompt, model, retrieval snapshot/index, tool contract, policy, then evaluator. Compare structured traces and output criteria, not only raw text. Non-determinism requires repeated trials and distribution-level evidence.

## Escalation Package

Include redacted minimal reproduction, manifest IDs, trace/timing breakdown, frequency and affected segment, evaluation delta, policy decision, mitigation, and whether any data exposure or external action occurred. Escalate security, privacy, or consequential-action failures immediately under the applicable incident process.
