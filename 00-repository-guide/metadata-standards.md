---
title: Metadata Standards
description: Required YAML front matter, controlled values, and cross-reference rules for canonical repository content.
domain: Repository Management
subdomain: Content Governance
content_type: Quick Reference
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Annual
tags:
  - metadata
  - content-governance
  - front-matter
related:
  - content-lifecycle.md
  - adding-new-content.md
  - knowledge-engineering/implementation.md
---

# Metadata Standards

Durable Markdown documents use YAML front matter.

```yaml
---
title: Example Guide
description: One-sentence explanation of the document's purpose.
domain: Data Engineering
subdomain: Data Quality
content_type: Implementation Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - data-quality
  - testing
related:
  - ../03-data-engineering/README.md
---
```

## Required Fields

Every Active canonical document must include all fields in the order shown above. `tags` and `related` must each contain at least one value. Use `subdomain: Domain Overview` for a top-level subject README and `subdomain: Asset Overview` for a top-level reusable-asset README.

Root navigation and Git community files (`README.md`, `START-HERE.md`, `CONTRIBUTING.md`, and `CHANGELOG.md`) may omit front matter. Inbox, review-required, archive, generated, and baseline-evidence files retain their lifecycle state and are not made Active merely to normalize metadata.

## Controlled Values

### Content Type

Overview, Concept Guide, Architecture Guide, Pattern Guide, Implementation Guide, SOP, Runbook, Troubleshooting Guide, Quick Reference, Cheat Sheet, Learning Path, Example, Template, Prompt, Decision Record, Meeting Guide, or Research Note.

### Level

Beginner, Intermediate, Advanced, Beginner to Pro, or All Levels.

### Status

Draft, Active, Review Required, Superseded, or Archived.

### Scope

General, Organization-Specific, or Project-Specific.

### Review Cycle

Quarterly, Semiannual, Annual, or Event-driven.

## Active Content

Active documents require an owner, an actual review date, a review cycle, valid related links, and current primary-source verification where product or policy behavior can change.

Use paths relative to the document. Each `related` entry must resolve to an explicit file or supporting artifact, must not repeat another entry or point to the document itself, and should prefer the applicable Active canonical guide over a draft. Related metadata improves discovery but does not make a target authoritative.

## Scope and Public Safety

- `General` content must not depend on a particular organization's environment or decisions.
- `Organization-Specific` and `Project-Specific` content belongs under `11-project-delivery/`, must show a visible scope notice, and must omit credentials, personal data, tenant identifiers, private endpoints, and confidential case details.
- Use `Review Required` when organization-specific accuracy, ownership, or publication authority still needs confirmation. Do not link it as canonical guidance.

Do not update `last_reviewed` merely because a file moved or its formatting changed.
