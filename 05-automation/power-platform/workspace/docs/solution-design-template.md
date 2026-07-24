---
title: Power Platform Solution Design Template
description: Template for documenting the design, ownership, security, operations, testing, and deployment of a Power Platform solution.
domain: Automation
subdomain: Power Platform
content_type: Template
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Annual
tags:
  - solution-design
  - template
  - power-platform
related:
  - architecture.md
  - ../governance.md
---

# Power Platform Solution Design Template

## Identity

- Business purpose:
- Solution unique name:
- Display name:
- Publisher and prefix:
- Business owner:
- Technical owner:
- Support owner:
- Environments:
- Data classification:

## Scope and Components

- Business process and boundaries:
- Dataverse tables, relationships, alternate keys, and ownership:
- Cloud flows:
- Reusable child flows:
- Canvas or model-driven apps:
- Power Pages:
- Custom connectors:
- PCF, plug-ins, custom APIs, and web resources:
- AI Builder or Copilot Studio components:
- External systems and dependencies:

## Configuration and Security

- Connection references:
- Environment variables:
- Secret-management approach:
- Service/workload identities:
- Roles, teams, sharing, and field security:
- DLP and connector classification:
- Audit, retention, and privacy:

## Reliability and Operations

- Correlation and business operation IDs:
- Idempotency:
- Retry, timeout, and compensation:
- Failure capture and reconciliation:
- Monitoring and alerts:
- Capacity, licensing, and performance:
- Support model and runbook:

## Testing and Delivery

- Unit/component tests:
- Persona and security tests:
- Integration and end-to-end tests:
- Failure/recovery tests:
- Accessibility and performance tests:
- Deployment settings:
- Test/UAT evidence:
- Production release:
- Rollback or forward-fix plan:
- Ownership acceptance:
