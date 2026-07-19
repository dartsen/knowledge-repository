---
title: Knowledge Engineering Security and Governance
description: Controls for knowledge classification, access, provenance, privacy, poisoning, rights, and lifecycle.
domain: Repository Management
subdomain: Knowledge Engineering
content_type: Concept Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - knowledge-governance
  - knowledge-security
  - provenance
related:
  - architecture.md
  - operations.md
---

# Knowledge Engineering Security and Governance

## Classification and Access

Classify source and output independently: synthesis can reveal more than any individual source. Enforce least privilege in the canonical store, build pipeline, search/index layer, cache, export, evaluation set, and AI retrieval path. Security trimming after retrieval can leak titles, snippets, counts, or embeddings; apply authorization before results enter the application context and validate again at delivery.

Keep secrets, credentials, personal data, protected customer data, confidential contracts, and live environment identifiers out of General-scope content. Use approved restricted systems for sensitive knowledge and synthetic examples in this repository.

## Provenance and Integrity

Record source, actor, transformation/review activity, time, and derived product for material guidance. Protect commits, review evidence, build artifacts, and indexes against unauthorized change. Verify source domains and integrity for automated ingestion. New or changed sources enter a review/quarantine path before becoming canonical or retrievable.

Treat documents as untrusted input to AI. Instructions embedded in a source must not override application policy, reveal protected context, or invoke tools. Content approval is distinct from authorization to execute instructions.

## Governance Roles

| Role | Accountability |
|---|---|
| Knowledge owner | Purpose, correctness, review, status, retirement |
| Source/data owner | Authority, classification, permitted use, access changes |
| Repository maintainer | Structure, metadata, lifecycle, validation, continuity |
| Reviewer/subject expert | Evidence-based technical and operational quality |
| Security/privacy/legal | Risk, personal/confidential data, rights, controls, incidents |
| Search/AI operator | Derived-index provenance, permission parity, quality, removal |

Separate authoring, approval, and production publication for high-risk policy or operational content.

## Rights, Privacy, and Retention

Capture license, attribution, permitted transformations, geographic or contractual restrictions, and deletion/retention obligations. Quotation and derived artifacts must comply with the source's terms. Minimize reader/search telemetry, set a purpose and retention period, restrict access, and avoid reconstructing sensitive behavior from query logs.

## Lifecycle Controls

Define allowed statuses, transitions, approvers, evidence, review cadence, exception expiry, and deletion/archive behavior. Superseded content must not remain equally discoverable as current authority. Urgent withdrawal needs a documented kill path for navigation, search, caches, exports, and AI corpora.

## Threat Review

Consider malicious contribution, compromised source, dependency or build compromise, hidden prompt injection, metadata manipulation, link substitution, unauthorized indexing, stale ACLs, cache leakage, corpus exfiltration, inference from aggregates, and denial of publication/retrieval. Test the controls and incident path proportionately.
