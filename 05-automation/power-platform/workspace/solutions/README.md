---
title: Power Platform Solution Projects
description: Placement and source-control rules for local PAC-generated Dataverse solution projects.
domain: Automation
subdomain: Power Platform
content_type: Quick Reference
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Annual
tags:
  - power-platform-solutions
  - cdsproj
  - source-control
related:
  - ../README.md
  - ../workspace-setup.md
---

# Power Platform Solution Projects

Create one directory per solution unique name. A PAC clone should produce a `.cdsproj` and supported source representation. Preserve generated structure, review diffs, and avoid hand-editing unsupported generated files.

Do not commit build output, packages, local settings, credentials, or live environment bindings. Development source should represent an unmanaged solution; approved builds produce managed packages for downstream environments.
