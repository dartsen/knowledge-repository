---
title: Power Platform Implementation Guide
description: Production implementation sequence for solutions, Dataverse, apps, flows, sites, agents, code, testing, source, and deployment.
domain: Automation
subdomain: Power Platform
content_type: Implementation Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-platform-alm
  - solutions
  - testing
related:
  - README.md
  - architecture.md
---

# Power Platform Implementation Guide

## Build Sequence

1. Document the process, users, data, critical path, exceptions, volume, objectives, classification, owners, licensing, and product selection.
2. Provision the approved development environment and create a custom solution with an organization-owned publisher. Keep production work out of default solutions.
3. Model Dataverse grain, GUID identifiers, alternate business keys, relationships, state/status, ownership, roles/teams, auditing, and retention before building screens and flows.
4. Add environment variables for nonsecret environment-specific values and connection references for solution-aware connections. Use approved secret/runtime identity mechanisms; never store plaintext secrets in variables, formulas, flows, source, examples, or logs.
5. Build apps with reusable components/formulas, delegation-aware queries, loading/error/empty/accessibility states, and explicit authorization. Security must be enforced at data and service boundaries, not only by hiding controls.
6. Build flows with trigger filters, input validation, modular child flows, tracked business-operation IDs, timeouts, idempotency, bounded retry, scopes for try/catch/finally behavior, terminal-failure capture, and reconciliation.
7. Build Power Pages with external identity, least-privilege web roles/table permissions, input/output protections, site lifecycle, monitoring, and exposure testing. Build agents with approved knowledge, evaluations, tool restrictions, human approval, and fallback.
8. Place code components, plug-ins, custom APIs/connectors, flows, apps, sites, agents, tables, and required configuration in deliberate solution boundaries. Document dependencies and component ownership.
9. Run Solution Checker plus unit/component, role/persona, contract, end-to-end, performance/limit, accessibility, security, failure/recovery, and deployment tests.
10. Commit solution source with the approved workflow, review diffs, build an immutable versioned artifact, and deploy the same managed artifact through test/UAT to production with approved configuration and smoke tests.

## Current Source-Control Choices

Microsoft's current native Dataverse Git integration connects Managed Environment development environments or custom solutions to Azure DevOps Git; Microsoft intends the Git-connected authoring path for development rather than test or production. It writes the YAML solution source format. Microsoft recommends YAML for new projects; XML remains for existing repositories or legacy tooling. Build managed artifacts from source and deploy them to downstream test, UAT, and production environments. Select native Git, PAC CLI/Build Tools, GitHub/Azure DevOps workflows, and in-product pipelines from team capability and control needs; avoid two competing sources of truth.

## Release Gate

Require business acceptance; solution and dependency inventory; security/data-policy/licensing review; source and artifact traceability; checker/tests; deployment settings; production owner connections/workload identities; managed target solution; backup/rollback or forward-fix decision; monitoring; runbook; support/ownership; and version record.

Microsoft documents pipelines as deploying solutions and target configuration, not Dataverse business data. Plan reference/configuration data migration separately and validate it.
