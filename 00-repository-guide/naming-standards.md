---
title: Naming Standards
description: Naming conventions for repository folders, Markdown files, titles, and tracked renames.
domain: Repository Management
subdomain: Content Governance
content_type: Quick Reference
level: Beginner
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Annual
tags:
  - naming
  - content-governance
  - repository-structure
related:
  - repository-structure.md
  - adding-new-content.md
---

# Naming Standards

## Folders

Use lowercase kebab-case. Numeric prefixes are reserved for intentional top-level order.

Good examples:

- `power-automate`
- `data-quality`
- `incident-response`

## Markdown Files

Use descriptive lowercase kebab-case names:

- `api-reliability-patterns.md`
- `power-platform-environment-strategy.md`
- `dbt-testing-strategy.md`

Avoid `notes.md`, `guide.md`, `final.md`, `misc.md`, `test.md`, generic numbered examples, and version suffixes such as `final-v2.md`.

`README.md`, `START-HERE.md`, `CONTRIBUTING.md`, and `CHANGELOG.md` are recognized navigation exceptions.

## Titles

Use official product capitalization in document titles, including Power Automate, Power BI, GitHub, Databricks, dbt, and UiPath.

## Renaming

Use `git mv` for tracked files. Update every relative link in the same change and record large migrations in the movement map.
