---
title: "Unity Catalog Governance Checklist"
domain: "Data Engineering"
level: "Beginner to Pro"
status: "Phase 3 Draft"
last_updated: "2026-06-20"
tags:
  - data-engineering
  - unity-catalog
  - governance
related:
  - ../
---

# Unity Catalog Governance Checklist

## Ownership

- [ ] Business owner identified
- [ ] Data owner identified
- [ ] Technical owner identified
- [ ] Support owner identified
- [ ] Downstream consumers documented

## Access

- [ ] Access requirements documented
- [ ] Least privilege applied
- [ ] Group-based access preferred
- [ ] Service principal access reviewed
- [ ] Sensitive data classified
- [ ] Access review cadence defined

## Data Quality

- [ ] Required fields identified
- [ ] Grain documented
- [ ] Key tests defined
- [ ] Relationship tests defined
- [ ] Freshness expectations defined
- [ ] Reconciliation checks defined where needed
- [ ] Data quality failure behavior defined

## Change Management

- [ ] Upstream impact assessed
- [ ] Downstream impact assessed
- [ ] Tests run before deployment
- [ ] Breaking changes communicated
- [ ] Rollback or remediation plan defined
- [ ] Release notes documented

## Auditability

- [ ] Code version-controlled
- [ ] Job history available
- [ ] Test results available
- [ ] Lineage available
- [ ] Access logs available
- [ ] Decision records available

## Operational Readiness

- [ ] Monitoring configured
- [ ] Alerts configured
- [ ] Runbook available
- [ ] SLA or refresh expectation defined
- [ ] Support process documented
- [ ] Incident review process defined

## Continuous Improvement

- [ ] Metrics reviewed periodically
- [ ] Technical debt tracked
- [ ] Lessons learned captured
- [ ] Unused assets reviewed
- [ ] Documentation updated
