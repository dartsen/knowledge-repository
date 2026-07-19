---
title: Automation
description: Navigation for process design, Power Platform, UiPath, automation patterns, governance, and operations.
domain: Automation
subdomain: Domain Overview
content_type: Overview
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - automation
  - power-platform
  - uipath
related:
  - ../01-enterprise-architecture/README.md
  - ../08-devops/README.md
  - ../09-security-governance/README.md
---

# Automation

## Scope

Use this domain to analyze business processes; design, build, govern, and operate automations; and select the appropriate combination of workflow, low-code applications, RPA, APIs, data, and AI.

## Recommended Starting Point

Start with process design and automation suitability. Choose Power Platform, UiPath, APIs, or a hybrid only after documenting boundaries, failure behavior, ownership, and support requirements.

## Key Concepts

- Process discovery, suitability, and improvement
- Orchestration, reusable components, and business rules
- Power Automate, Power Apps, Dataverse, Power Pages, Copilot Studio, and AI Builder
- UiPath workflows, queues, assets, and Orchestrator
- Idempotency, retries, exception handling, and compensation
- Telemetry, support ownership, SLAs, and runbooks
- Environment strategy, ALM, identity, licensing, and governance

## Common Uses

- Design a new automation or modernize an existing one.
- Choose between API, cloud flow, desktop automation, and low-code application patterns.
- Standardize reliability and error handling.
- Establish deployment, monitoring, support, and governance controls.
- Review an automation for production readiness.

## Platform and Pattern Guides

- [Power Platform](power-platform/README.md)
- [Power Automate engineering library](power-platform/power-automate/README.md)
- [UiPath](uipath/README.md)
- [UiPath repeatable patterns](uipath/repeatable-patterns.md)
- [Automation Monitoring](automation-monitoring/README.md)
- [Exception Handling](exception-handling/README.md)

Confirm each linked guide's `status` before treating it as authoritative.

## Learning Sequence

```text
Process design → Platform selection → Architecture → Implementation patterns
→ Testing and ALM → Monitoring and support → Governance and improvement
```

## Related Domains

- [Enterprise Architecture](../01-enterprise-architecture/README.md)
- [Software Engineering](../02-software-engineering/README.md)
- [DevOps](../08-devops/README.md)
- [Security and Governance](../09-security-governance/README.md)
