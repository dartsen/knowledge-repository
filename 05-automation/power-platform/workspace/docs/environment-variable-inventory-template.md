---
title: Power Platform Environment Variable Inventory Template
description: Placeholder-only inventory for environment-variable purpose, stage categories, security, ownership, and validation.
domain: Automation
subdomain: Power Platform
content_type: Template
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Annual
tags:
  - environment-variable
  - inventory
  - template
related:
  - connection-inventory-template.md
  - ../deployment-settings/README.md
---

# Power Platform Environment Variable Inventory Template

Record value categories and validation rules, not live environment values.

| Schema name | Display name | Data type | Purpose | Development value category | Test value category | UAT value category | Production value category | Secret | Required | Owner | Validation rule |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `replace_SchemaName` | Replace display name | Text/JSON/Number/Boolean/Data source/Secret | Replace purpose | Placeholder | Placeholder | Placeholder | Placeholder | Yes/No | Yes/No | Role/team | Describe allowed format |
