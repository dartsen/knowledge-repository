---
title: Power Platform Security and Governance
description: Controls for Power Platform environments, data policies, identities, Dataverse, external sites, agents, connectors, ALM, and evidence.
domain: Automation
subdomain: Power Platform
content_type: Concept Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-platform-security
  - data-policies
  - managed-environments
related:
  - README.md
  - ../../09-security-governance/README.md
---

# Power Platform Security and Governance

## Layered Controls

| Layer | Decisions |
|---|---|
| Tenant | Admin roles, environment creation/routing, sharing, connectors, AI/Copilot, APIs/service principals, trial and default-environment policy |
| Environment/group | Purpose, region, Dataverse, security group, Managed Environments, group rules, data policies, retention, maker/admin access |
| Solution/ALM | Publisher/owner, source, review, checker/tests, artifact, pipeline identity/approval, managed downstream deployment, configuration and rollback |
| Dataverse | Business units/teams/roles, table privileges, row ownership/sharing, column security, application users, auditing, encryption, retention |
| App/flow | User and owner sharing, run-only permissions, connector actions, service/workload identity, trigger/input authorization, sensitive output/logging |
| Power Pages | External identities, web roles, table permissions, site visibility, forms/API exposure, uploads, headers/configuration, monitoring |
| Agents/AI | Knowledge and data sources, channels, data-policy/MCP connector control, tool permissions, human approval, evaluation, fallback and audit |
| Professional code | Secure coding, dependency/provenance, plug-in isolation/limits, custom API/connector auth, secrets, tests and monitoring |

## Data Policies

Power Platform data policies govern connector use and combinations for Power Apps, Power Automate, and Copilot Studio. Treat changes as production changes: inventory affected resources, test design-time and runtime behavior, communicate, monitor enforcement, and provide an exception process. A connector being allowed or certified does not authorize a user to specific data.

## Identity Rules

Use Microsoft Entra groups for scalable access, separate maker/user/admin/support roles, least-privilege Dataverse roles, and supported service-principal/workload identities for automation and deployment. Avoid personal accounts as production component owners or connections. Protect and rotate any required credentials through approved systems; audit privileged/emergency access.

## Governance at Scale

Classify environments by purpose/risk, route personal development where appropriate, apply Managed Environments and environment groups when licensing and controls fit, and keep production/UAT/test separated. Inventory and act on orphaned, unused, overshared, noncompliant, or unsupported assets. Exceptions need business owner, risk, compensating control, expiry, and review.

## Organization-Specific Boundary

This is General guidance. Real environment/group names, tenant policy, identities, URLs, custom connectors/endpoints, DLP classification, production ownership, licensing positions, incident contacts, and review findings belong in labeled organization/project records. Never publish credentials or sensitive configuration.
