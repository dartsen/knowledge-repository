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
  - ../data-quality/README.md
---
```

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

Do not update `last_reviewed` merely because a file moved or its formatting changed.

