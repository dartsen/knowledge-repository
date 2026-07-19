---
title: Platform Engineering
description: Production guidance for building and operating internal platforms as governed products for delivery teams.
domain: DevOps
subdomain: Platform Engineering
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - platform-engineering
  - internal-developer-platform
  - developer-experience
related:
  - ../README.md
  - ../../14-learning-paths/devops/platform-engineering.md
  - ../../15-examples/devops/internal-api-golden-path.md
---

# Platform Engineering

Platform engineering applies product thinking to shared capabilities that reduce delivery-team cognitive load while preserving autonomy, security, reliability, and cost accountability. An internal platform is the integrated user experience and contract around capabilities; it is not merely a portal, Kubernetes cluster, or central operations team.

## Start Here

1. [Architecture](architecture.md) - define users, capabilities, interfaces, control boundaries, and tenancy.
2. [Implementation](implementation.md) - build a minimum viable platform and golden paths incrementally.
3. [Operations](operations.md) - run the platform as a reliable product and shared dependency.
4. [Security and governance](security-governance.md) - embed policy, isolation, supply-chain, and evidence controls.
5. [Troubleshooting](troubleshooting.md) - diagnose provisioning, delivery, runtime, catalog, and adoption failures.
6. [Official references](official-references.md) - current CNCF, Kubernetes, Backstage, NIST, SLSA, and Microsoft sources.

Follow the centralized [platform engineering learning path](../../14-learning-paths/devops/platform-engineering.md), then apply the [internal API golden-path worked example](../../15-examples/devops/internal-api-golden-path.md).

The [product-discovery and rollout supplement](implementation-guide.md) extends the canonical implementation guide with journey measures, pilot controls, and template quality gates. The [operator runbook](operations-runbook.md) provides an incident, lifecycle, and reconciliation checklist for the shared control plane.

## Platform Product Contract

| Element | Required decision |
|---|---|
| Users and jobs | Which delivery teams and tasks are in scope? |
| Value | Which lead time, failure, toil, risk, or discoverability outcome should improve? |
| Capabilities | What is offered now, later, or explicitly not offered? |
| Interfaces | Portal, API, CLI, templates, documentation, support, and extension points |
| Responsibility | Platform-managed, user-managed, provider-managed, and shared boundaries |
| Service levels | Provisioning, platform API, support, recovery, and deprecation commitments |
| Guardrails | Identity, policy, isolation, supply chain, observability, cost, and exceptions |
| Feedback | Adoption, task success, satisfaction, reliability, and roadmap process |

## Principles

- Discover real user friction before selecting a portal or orchestrator.
- Build the thinnest useful layer over reliable provider capabilities.
- Offer supported golden paths, not mandatory golden cages; make escape paths and responsibilities explicit.
- Treat templates, APIs, documentation, and policies as versioned products.
- Measure successful outcomes and voluntary adoption, not catalog size or provisioned-resource count alone.
- Keep application teams accountable for their software while the platform owns its contract and shared controls.

## Organization-Specific Adoption Notes

> **Scope: Organization-Specific.** Local team boundaries, cloud accounts, clusters, portal URLs, access groups, cost centers, exception authorities, and roadmap commitments belong in Project Delivery. Public examples use fictitious names and placeholders.
