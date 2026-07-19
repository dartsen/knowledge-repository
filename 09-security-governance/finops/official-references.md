---
title: FinOps Official References
description: Primary references for the FinOps Framework, FOCUS, and Microsoft cost-management implementation.
domain: Security and Governance
subdomain: FinOps
content_type: Quick Reference
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - finops-references
  - focus
  - microsoft-cost-management
related:
  - README.md
  - troubleshooting.md
---

# FinOps Official References

Checked 2026-07-18. Revalidate version-dependent product behavior, schemas, pricing, and permissions before implementation.

## FinOps Foundation

- [FinOps Framework](https://www.finops.org/framework/) - current definition, principles, personas, domains, capabilities, scopes, and maturity
- [FinOps phases](https://www.finops.org/framework/phases/) - iterative Inform, Optimize, and Operate cycle
- [2026 Framework update](https://www.finops.org/insights/2026-finops-framework/) - Executive Strategy Alignment, broader technology categories, and refined scopes
- [Allocation capability](https://www.finops.org/framework/capabilities/allocation/) - allocation intent and practice
- [Data ingestion capability](https://www.finops.org/framework/capabilities/data-ingestion/) - cost and usage data foundations

## FOCUS

- [FOCUS specification](https://focus.finops.org/focus-specification/) - uniform technology billing-data requirements
- [FOCUS adoption guidance](https://focus.finops.org/get-started/) - available data generators and practitioner adoption

At the checked date, FOCUS 1.4 is the latest ratified version (2026-06-04). Pin the implemented schema version and verify each provider's support; do not silently upgrade pipelines when the specification or vendor export changes.

## Microsoft Implementation

- [FinOps on Microsoft Cloud](https://learn.microsoft.com/en-us/cloud-computing/finops/) - Microsoft implementation guidance aligned to the FinOps Framework
- [Microsoft Cost Management overview](https://learn.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview) - billing and cost-management boundaries
- [Understand Cost Management data](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data) - estimates, exclusions, and invoice behavior
- [Automate Cost Management](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/manage-automation) - exports, APIs, budgets, and controlled responses
- [Analyze unexpected charges](https://learn.microsoft.com/en-us/azure/cost-management-billing/understand/analyze-unexpected-charges) - anomaly behavior and investigation
- [FinOps practice operations](https://learn.microsoft.com/en-us/cloud-computing/finops/framework/manage/operations) - team, cadence, and maturity guidance

## Qualification Notes

- FinOps maximizes technology value; it is not synonymous with minimizing cost.
- Cost data for an open period may be estimated, delayed, incomplete, or later corrected.
- A budget notification does not by itself impose a hard spending cap.
- FOCUS normalizes billing data, not organization-specific ownership or allocation decisions.
- Provider features, supported scopes, permissions, and contract terms remain authoritative for a deployment.
