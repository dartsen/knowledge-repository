---
title: Worked Example - Grounded Support Assistant
description: End-to-end production AI example with authorized retrieval, citations, a read-only tool, evaluation, observability, and safe failure.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - production-ai
  - rag
  - worked-example
related:
  - ../../06-artificial-intelligence/production-engineering/README.md
---

# Worked Example: Grounded Support Assistant

## Problem and Assumptions

A fictional internal support team needs an assistant that answers from approved product guides and can read a synthetic case status after the signed-in user supplies a case number. It cannot create, edit, close, or escalate cases. All users, sources, endpoints, case data, and identifiers are synthetic.

## Architecture

```text
Authenticated support portal
 -> request policy, rate limit, and correlation ID
 -> orchestrator
    -> ACL-filtered retrieval over approved, versioned support sources
    -> approved model deployment with bounded context and timeout
    -> read-only case-status tool with server-side authorization/schema checks
 -> citation and structured-output validation
 -> answer, explicit uncertainty, or human escalation

Release manifest + evaluation suite -> gated deployment
Protected traces/metrics + sampled evaluation -> operations and incidents
```

Retrieved content is labeled untrusted and cannot override system instructions or tool policy. The case tool returns only the minimum status fields authorized for that user. The application never accepts model output as proof of identity or permission.

## Implementation and Evaluation

The release manifest pins code, model deployment, prompt, source snapshot/index, tool schema, policy, evaluator, and test dataset. Evaluation covers answer correctness, source relevance, citation support, explicit no-evidence behavior, structured-output validity, authorized and unauthorized case access, prompt injection in a document, malformed case numbers, tool timeout, harmful requests, long context, and prior regressions.

The release gate has separate thresholds for critical authorization/safety failures and task quality; a good average cannot offset a critical failure. Human reviewers calibrate automated groundedness and relevance evaluators on a representative sample.

## Operations and Failure

Traces correlate retrieval, model, policy, and tool calls without storing raw content by default. Dashboards segment error, latency, tokens/cost, empty retrieval, citation coverage, tool results, refusals, escalations, and sampled quality by release. A missing source yields a clear limitation and escalation, not an invented answer. A tool outage returns documentation-only assistance. A quality regression halts canary expansion and restores the compatible prior release set.

## Security and Governance

Source owners approve and review content; ingestion records provenance and ACLs. Retrieval rechecks authorization for every request. The model identity cannot write to case data. Production samples require approved minimization, redaction, access, retention, and deletion. Risk, privacy, security, accessibility, operations, and support owners approve release evidence.

## Acceptance

Demonstrate supported answers with valid citations, no-evidence escalation, denial of unauthorized case access, resistance to document prompt injection, a bounded tool timeout, an evaluated fallback, canary abort and rollback, protected incident evidence, and no secret or real organizational data in code or telemetry.
