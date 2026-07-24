---
title: Power Platform Deployment Settings
description: Safe use of placeholder and local deployment settings for environment variables and connection references.
domain: Automation
subdomain: Power Platform
content_type: Quick Reference
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - deployment-settings
  - connection-references
  - environment-variables
related:
  - ../README.md
  - ../docs/connection-inventory-template.md
---

# Power Platform Deployment Settings

The tracked `settings.example.json` files contain placeholders only. Copy the applicable file to `settings.local.json`, populate it through an approved process, and keep it out of Git.

PAC deployment settings can bind connection references and supply environment-variable values. They do not replace credential management: target connections and their authentication remain controlled Power Platform resources.

```powershell
Copy-Item .\deployment-settings\test\settings.example.json `
    .\deployment-settings\test\settings.local.json
```

Validate the local file, restrict access, avoid logging its values, and review it before every import. Use a separate file per stage; never reuse Development configuration in Production.
