---
title: Integration Security and Governance
description: Governance for integration identity, contracts, sensitive data, change, and operational evidence.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Pattern Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - api-security
  - integration-governance
  - data-protection
related:
  - README.md
  - ../../09-security-governance/README.md
---

# Integration Security and Governance

## Trust Boundary Controls

- Authenticate workload identities; avoid shared human credentials for system integration.
- Authorize the caller, tenant, operation, and resource; token possession alone is insufficient.
- Validate token issuer, audience, signature, lifetime, and required scopes or claims.
- Follow RFC 9700 for current OAuth 2.0 security practice when OAuth applies.
- Encrypt in transit and at rest; govern certificates, keys, and secret rotation.
- Validate and constrain schema, content type, payload size, decompression, filenames, and archive contents.
- Minimize data and prevent sensitive values from entering URLs, event routing attributes, metric labels, or broad logs.

## Contract Governance

Assign an owner and lifecycle state to every published contract. Require compatibility checks, security/data review proportional to risk, consumer notification, deprecation period, and exception approval for breaking changes. Keep specifications and policy in version control; deploy from reviewed artifacts.

## Messaging and Event Controls

Use separate identities and permissions for publish, consume, manage, replay, and purge. Restrict dead-letter and replay access because failed payloads can contain sensitive data and replay causes business side effects. Protect routing metadata from tenant or classification leakage.

## Partner and Public Boundary

Document legal purpose, allowed data, network and identity requirements, quotas, support, incident notification, certificate rollover, offboarding, and deletion. Assume partner retries and duplicates. Do not trust a partner-provided correlation ID as authorization or tenant identity.

## Evidence

Retain contract approval, consumer inventory, access decision, test evidence, deployed version, change record, replay/correction record, reconciliation result, and retirement decision under the applicable retention policy.

## Organization-Specific Adoption Notes

> **Scope: Organization-Specific.** Local gateway rules, broker permissions, partner contacts, tenant identifiers, certificates, endpoints, and data-processing agreements belong in controlled Project Delivery material. Use sanitized placeholders in this public repository.
