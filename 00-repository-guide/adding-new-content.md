---
title: Adding New Content
description: Decision process for placing, scoping, and governing new durable repository content.
domain: Repository Management
subdomain: Content Governance
content_type: Implementation Guide
level: Beginner
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Annual
tags:
  - content-placement
  - canonical-content
  - contribution
related:
  - README.md
  - metadata-standards.md
  - content-lifecycle.md
---

# Adding New Content

## Decision Tree

```mermaid
flowchart TD
    A["New material"] --> B{"Durable knowledge?"}
    B -->|No| C["Keep with the temporary project or meeting workspace"]
    B -->|Yes| D{"Canonical document already exists?"}
    D -->|Yes| E["Update the canonical document"]
    D -->|No| F{"Clear subject and authority?"}
    F -->|No| G["Place in 90-inbox"]
    F -->|Yes| H{"Reusable asset type?"}
    H -->|Template| I["12-templates"]
    H -->|Reference| J["13-reference"]
    H -->|Learning path| K["14-learning-paths"]
    H -->|Worked example| L["15-examples"]
    H -->|Prompt| M["16-prompts"]
    H -->|No| N{"Organization or project specific?"}
    N -->|Yes| O["11-project-delivery with scope metadata"]
    N -->|No| P["Primary subject domain"]
```

## Questions to Answer

1. Is the material durable knowledge or temporary project work?
2. Is it organized around a subject, technology, capability, or reusable asset?
3. Is it a guide, template, prompt, example, reference, runbook, or decision record?
4. Does a canonical document already cover the same purpose and audience?
5. Should the existing document be extended instead of creating a new file?
6. Is the content general, organization-specific, or project-specific?
7. Who can verify and maintain it?

When the answer remains unclear, use `90-inbox/` and create a review note rather than guessing.
