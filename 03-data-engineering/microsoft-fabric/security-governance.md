---
title: Microsoft Fabric Security and Governance
description: Controls for Fabric tenants, capacities, workspaces, items, identities, data, sharing, networks, and lifecycle.
domain: Data Engineering
subdomain: Microsoft Fabric
content_type: Concept Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - fabric-security
  - fabric-governance
  - purview
related:
  - README.md
  - ../../09-security-governance/README.md
---

# Microsoft Fabric Security and Governance

## Control Layers

1. **Tenant:** authorize Fabric creation/use, external sharing, service principals/APIs, Git, export, AI/Copilot, and other tenant capabilities according to policy.
2. **Capacity:** restrict administration, assign approved workspaces, monitor workload isolation and cost, and control scale/pause actions.
3. **Domain/workspace:** use accountable owners, group-based roles, environment separation, least privilege, and periodic access/ownership review.
4. **Item/data:** apply item permissions, SQL/data-plane permissions, semantic row/object-level security, sensitivity labels, data classification, and sharing rules appropriate to the engine.
5. **Connection/network:** use approved identities and gateways/private connectivity where supported; govern outbound/inbound paths and source-side permissions.
6. **Lifecycle:** review Git/deployment identities, approvals, supported items, configuration, activity evidence, retention, deletion, recovery, and deprecation.

Workspace roles are broad collaboration roles and can be assigned to users, groups, and supported service principals. They do not replace item, SQL, semantic, source, or network authorization. Test access as each persona and from each consumption path.

## Data Governance

Catalog products and items with owner, business definition, grain, classification, quality/freshness, lineage, source, consumers, endorsement, retention, and lifecycle. Use Microsoft Purview/Fabric capabilities where appropriate, but validate actual lineage and label propagation for every item/export path. Shortcuts and sharing do not transfer accountability for source data.

## Sensitive Data and Secrets

Minimize data, use synthetic test fixtures, and prohibit credentials/tokens from notebooks, item definitions, parameters committed to Git, pipeline output, logs, and examples. Use supported secret/connection mechanisms and workload identities, rotate access, and review service-principal scope. Treat notebook output and exported report/data files as governed data.

## Governance Gates

Require product ownership, classification, environment/capacity placement, access model, source and egress review, contract/tests, lifecycle path, operational objectives, recovery evidence, cost attribution, and preview exceptions before production. Keep organization-specific tenant settings and access-group names in a labeled controlled overlay.
