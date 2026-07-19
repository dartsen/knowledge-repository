---
title: Microsoft Power Platform
description: Canonical production guidance across Power Apps, Power Automate, Dataverse, Power Pages, Copilot Studio, AI Builder, and professional extensibility.
domain: Automation
subdomain: Power Platform
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-platform
  - low-code
  - dataverse
related:
  - ../README.md
  - ../../14-learning-paths/automation/power-platform.md
  - ../../15-examples/automation/power-platform/employee-onboarding-solution.md
---

# Microsoft Power Platform

Power Platform is a low-code application, automation, data, website, and agent ecosystem. A production solution may combine Power Apps, Power Automate, Dataverse, Power Pages, Copilot Studio, AI Builder, connectors, Power Fx, code components, plug-ins/custom APIs, Azure services, and Power BI. Use each capability within an explicit workload boundary, data model, identity model, environment strategy, ALM path, operating model, and licensing/capacity decision.

## Start Here

1. [Architecture](architecture.md) — workload, component, data, integration, identity, environment, and reliability design.
2. [Product capabilities](product-capabilities.md) — selection boundaries for the complete platform.
3. [Implementation](implementation.md) — solutions, Dataverse, makers, code, testing, source control, and deployment.
4. [Operations](operations.md) — inventory, ownership, monitoring, support, capacity/licensing, and lifecycle.
5. [Security and governance](security-governance.md) — environments, data policies, roles, identities, sharing, agents, and evidence.
6. [Troubleshooting](troubleshooting.md) — apps, flows, Dataverse, sites, agents, connections, solutions, and policy.
7. [Official references](official-references.md) — current Microsoft primary documentation.
8. [Central learning path](../../14-learning-paths/automation/power-platform.md).
9. [Worked example](../../15-examples/automation/power-platform/employee-onboarding-solution.md).

## Preserved and Specialized Material

The prior [generated overview](legacy-generated-readme.md) and [expanded draft reference guide](reference-guide.md) are preserved but do not override this Active family. The [Power Automate engineering library](power-automate/README.md) provides deep flow patterns. Public [organization-specific current-state review](../../11-project-delivery/organization-specific/intelligent-automation/power-platform-current-state-review.md) and [remediation backlog](../../11-project-delivery/organization-specific/intelligent-automation/automation-remediation-modernization-backlog.md) remain clearly labeled in Project Delivery and are not general standards.

## Production Rule

Build production components inside custom solutions, separate development from downstream managed deployments, externalize environment-specific configuration, use service/workload-owned identities where supported, test business and failure paths, and assign business, technical, support, and platform owners before release.

## Current Governance Note

Microsoft states that the Power Platform CoE Starter Kit is no longer actively maintained and directs core inventory, usage, monitoring, and action scenarios to the Power Platform admin center. Continue using Center of Excellence as an operating-model concept, but do not create a new strategic dependency on the unmaintained kit without an explicit exception.
