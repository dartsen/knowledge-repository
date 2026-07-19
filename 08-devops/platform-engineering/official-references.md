---
title: Platform Engineering Official References
description: Current primary sources supporting repository platform engineering guidance.
domain: DevOps
subdomain: Platform Engineering
content_type: Research Note
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - official-documentation
  - platform-engineering
  - supply-chain-security
related:
  - README.md
  - architecture.md
---

# Platform Engineering Official References

Verified against active primary-source pages on **2026-07-18**. Platform products and project APIs change frequently; validate the selected release and migration guidance before implementation.

| Primary source | Guidance supported |
|---|---|
| [CNCF Platforms White Paper](https://tag-app-delivery.cncf.io/whitepapers/platforms/) | Internal platforms as integrated user-centered capabilities and platform teams using product practices |
| [CNCF Platform Engineering Maturity Model](https://tag-app-delivery.cncf.io/whitepapers/platform-eng-maturity-model/) | Balanced improvement across people, process, policy, technology, and business outcomes |
| [Microsoft: What is platform engineering?](https://learn.microsoft.com/en-us/platform-engineering/what-is-platform-engineering) | Internal developer platforms, product mindset, self-service, reusable building blocks, and feedback |
| [Backstage Software Catalog](https://backstage.io/docs/features/software-catalog/) | Version-controlled component metadata, ownership, discovery, and integrated tooling |
| [Backstage Software Templates](https://backstage.io/docs/features/software-templates/adding-templates/) | Cataloged templates and scaffolding definitions |
| [Backstage Permission Framework](https://backstage.io/docs/permissions/overview/) | Explicit authorization policies for portal resources and actions |
| [Kubernetes multi-tenancy](https://kubernetes.io/docs/concepts/security/multi-tenancy/) | Namespaces, RBAC, quotas, network policy, and stronger isolation choices |
| [NIST SP 800-218 SSDF 1.1](https://csrc.nist.gov/pubs/sp/800/218/final) | Final secure software development practices |
| [SLSA specification 1.2](https://slsa.dev/spec/v1.2/) | Approved source/build tracks, levels, provenance, and verification guidance |

## Verification Notes

- NIST listed SSDF 1.2 as a draft when reviewed; SP 800-218 SSDF 1.1 remained the final publication.
- SLSA 1.2 was marked Approved when reviewed. Pin the chosen specification version in policy and evidence tooling.
- Backstage endpoints and permissions depend on configured authentication and authorization. Review the documentation for the deployed version rather than assuming secure defaults.
- Kubernetes namespaces alone are not a complete hostile-tenant boundary.
