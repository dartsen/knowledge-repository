---
title: Worked Example - Canonical Knowledge Family
description: End-to-end knowledge-engineering example that turns scattered notes into one governed, searchable family.
domain: Repository Management
subdomain: Knowledge Engineering
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - knowledge-engineering
  - canonical-content
  - worked-example
related:
  - ../../00-repository-guide/knowledge-engineering/README.md
---

# Worked Example: Canonical Knowledge Family

## Problem and Assumptions

A fictional engineering group has three overlapping API-operation notes, an outdated vendor snippet, and a useful incident checklist. Readers cannot tell which advice is current. The team needs one General-scope canonical family, navigation, a learning path, a worked example, and a reproducible search index. All organization and system details are synthetic.

## Intake and Authority Decision

Each source receives an intake record with owner, origin, version/date, classification, rights, applicability, and candidate disposition. The maintainer compares normalized content and Git history. Current official specifications and verified operational evidence support the canonical guide; conflicting claims are shown to subject reviewers rather than silently merged.

One note becomes historical evidence in the archive, one live-looking but unverified note goes to review-required, and one checklist is adapted with provenance. Nothing is deleted merely because it is redundant.

## Canonical Family

```text
Domain README
 -> family README
    -> architecture
    -> implementation
    -> operations
    -> security and governance
    -> troubleshooting
    -> official references
 -> centralized learning path
 -> scenario-specific worked example
```

Every Active document has metadata, owner, status, review date/cycle, valid related links, distinct purpose, and at least one intended inbound navigation path. The learning path links to canonical content rather than copying it.

## Publication and Retrieval

Automated validation checks front matter, links, duplicate bodies, Active orphans, sensitive patterns, and file naming. Human review confirms sources, judgment, usability, and safe examples. After merge, a build records source commit, parser/schema, access policy, document/section IDs, index version, and known-query results. Chunks retain canonical path and section anchor.

## Failure Injection

The test introduces a broken relative link, missing owner, duplicated canonical paragraph, stale official version, unauthorized source, hidden prompt injection, and removed file that remains in the old index. Mandatory checks block publication. The operator withdraws the affected index alias, fixes the canonical source or permissions, rebuilds from the committed tree, and verifies known positive, negative, and access-controlled queries.

## Acceptance

Demonstrate one clear authority, traceable dispositions, zero unexpected broken links or Active orphans, no substantive Active duplicates, no sensitive values, a successful restore and reindex, removal of withdrawn content, permission parity, and a reader completing the target task from navigation or search.
