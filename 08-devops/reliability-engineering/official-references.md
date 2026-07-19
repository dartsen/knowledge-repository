---
title: Reliability Engineering Official References
description: Current primary sources supporting the repository reliability guidance.
domain: DevOps
subdomain: Reliability Engineering
content_type: Research Note
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - official-documentation
  - reliability
  - standards
related:
  - README.md
  - ../observability/official-references.md
---

# Reliability Engineering Official References

Verified against active primary-source pages on **2026-07-18**. Product, specification, and framework status can change; recheck the linked source before adopting version-specific behavior.

| Primary source | Guidance supported |
|---|---|
| [Google SRE Workbook: Implementing SLOs](https://sre.google/workbook/implementing-slos/) | User-centered SLIs, stakeholder-approved SLOs, error budgets, and documented policies |
| [Google SRE Workbook: Example Error Budget Policy](https://sre.google/workbook/error-budget-policy/) | Concrete consequences and escalation for budget exhaustion |
| [Google SRE Book: Monitoring Distributed Systems](https://sre.google/sre-book/monitoring-distributed-systems/) | User-impact monitoring, four golden signals, and simple actionable paging |
| [Microsoft Azure Well-Architected Framework: Reliability principles](https://learn.microsoft.com/en-us/azure/well-architected/reliability/principles) | Business-aligned targets, resilience, recovery, simplicity, and tested operations |
| [Microsoft Azure Well-Architected Framework: Reliability targets](https://learn.microsoft.com/en-us/azure/well-architected/reliability/metrics) | Measurable SLOs, recovery targets, and health models |
| [Microsoft Azure Architecture Center: Circuit Breaker pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker) | Persistent-fault isolation and the distinction between retry and circuit breaking |
| [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) | Incident response integrated with cybersecurity risk management; final publication dated April 2025 |

## Verification Notes

- Google SRE material is used as practice guidance, not as an organization-specific policy.
- Azure material is applied as quality-attribute guidance; vendor-specific service choices remain in Cloud Platforms.
- NIST SP 800-61 Rev. 3 supersedes Rev. 2. New incident-response material should not cite Rev. 2 as the current NIST publication.
- Availability percentages, recovery targets, error-budget thresholds, and severity definitions in examples are illustrative until approved for a real service.
