---
title: Integration Engineering Official References
description: Current primary standards and architecture sources supporting repository integration guidance.
domain: Enterprise Architecture
subdomain: Integration Architecture
content_type: Research Note
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - official-documentation
  - integration-standards
  - api-specifications
related:
  - README.md
  - architecture.md
---

# Integration Engineering Official References

Verified against active primary-source pages on **2026-07-18**. Pin specification versions in artifacts and recheck current security and compatibility guidance before implementation.

| Primary source | Guidance supported |
|---|---|
| [OpenAPI Specification index](https://spec.openapis.org/oas/) | Published OpenAPI versions and schemas; the index listed 3.2.0 as the newest version when reviewed |
| [AsyncAPI Specification](https://www.asyncapi.com/docs/reference/specification/latest) | Machine-readable message-driven API contracts; `latest` resolved to 3.1.0 when reviewed |
| [CloudEvents specification repository](https://github.com/cloudevents/spec) | Vendor-neutral event envelope, stable releases, and protocol/event-format bindings |
| [RFC 9110: HTTP Semantics](https://www.rfc-editor.org/rfc/rfc9110.html) | HTTP method semantics, safety, idempotency, status codes, and core protocol behavior |
| [RFC 9700: OAuth 2.0 Security Best Current Practice](https://www.rfc-editor.org/info/rfc9700/) | Current OAuth 2.0 security practice; BCP 240 published January 2025 |
| [W3C Trace Context](https://www.w3.org/TR/trace-context/) | Interoperable trace propagation across service boundaries |
| [Azure Architecture Center: Event-driven architecture](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven) | Producer, channel, consumer, publish-subscribe, streaming, consistency, and operating tradeoffs |
| [Azure Architecture Center: API design](https://learn.microsoft.com/en-us/azure/architecture/microservices/design/api-design) | Contract design, idempotency, compatibility, and versioning considerations |
| [Azure Architecture Center: Circuit Breaker](https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker) | Distinguishing persistent-fault isolation from retry behavior |

## Verification Notes

- CloudEvents `main` is a working draft. Use the repository's stable release/tag for production conformance.
- A specification version and an individual API's version are different values; record both.
- OAuth 2.1 was still described by RFC 9700 as under development. Do not cite a draft as a finalized standard.
- Microsoft architecture material supplies pattern guidance; it does not require Azure products for the vendor-neutral design.
