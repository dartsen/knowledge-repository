---
title: Microsoft Power Platform Learning Path
description: Central progression across Power Apps, Power Automate, Dataverse, Power Pages, Copilot Studio, AI Builder, ALM, operations, and governance.
domain: Automation
subdomain: Power Platform
content_type: Learning Path
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - power-platform
  - learning-path
related:
  - ../../05-automation/power-platform/README.md
  - ../../15-examples/automation/power-platform/employee-onboarding-solution.md
---

# Microsoft Power Platform Learning Path

## Stage 1 - Platform and Process

Read the [Power Platform overview](../../05-automation/power-platform/README.md) and [product capability boundaries](../../05-automation/power-platform/product-capabilities.md). Map one process, users, data, systems, exceptions, volume, classification, objectives, and owners before choosing products.

Evidence: process map, product selection, and non-goals.

## Stage 2 - Dataverse and Architecture

Read [Power Platform Architecture](../../05-automation/power-platform/architecture.md). Model tables with explicit grain, platform GUID primary identifiers, alternate business keys, relationships, security/ownership, state, audit, and integration contracts. Design environments and failure behavior.

Evidence: architecture, data model, identity matrix, and environment strategy.

## Stage 3 - Build the Experiences

Build a small canvas or model-driven app, a cloud flow, and a role-secured Dataverse path. Explore Power Pages for external access and Copilot Studio/AI Builder only with synthetic data and explicit evaluation/tool boundaries.

Evidence: accessible app, idempotent flow, persona tests, and AI evaluation where used.

## Stage 4 - Engineering and ALM

Read [Implementation](../../05-automation/power-platform/implementation.md) and the [Power Automate engineering library](../../05-automation/power-platform/power-automate/README.md). Package a custom solution, configuration and connection references, tests, source, versioned artifact, and managed deployment through separate environments.

Evidence: reviewed source diff, test report, deployment record, and rollback/forward-fix plan.

## Stage 5 - Security and Operations

Read [Security and Governance](../../05-automation/power-platform/security-governance.md), [Operations](../../05-automation/power-platform/operations.md), and [Troubleshooting](../../05-automation/power-platform/troubleshooting.md). Review data policies, Managed Environments, identities, external/site and agent boundaries, inventory, monitoring, licensing/capacity, support, and recovery.

Evidence: production-readiness review, runbook, access/policy tests, and recovery exercise.

## Capstone

Complete the [employee-onboarding solution](../../15-examples/automation/power-platform/employee-onboarding-solution.md). Demonstrate duplicate request handling, least-privilege roles, managed deployment, connector failure, approval timeout, reconciliation, owner continuity, and secret-free telemetry.

You are ready to lead when you can choose across the platform from requirements, keep Dataverse business identity separate from its GUID primary identifier, deliver through supported ALM, and explain operational, security, licensing, and AI tradeoffs.
