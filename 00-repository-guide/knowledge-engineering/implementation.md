---
title: Knowledge Engineering Implementation
description: Implementation method for intake, synthesis, metadata, provenance, validation, publication, and derived indexes.
domain: Repository Management
subdomain: Knowledge Engineering
content_type: Implementation Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - knowledge-authoring
  - metadata
  - content-validation
related:
  - architecture.md
  - operations.md
---

# Knowledge Engineering Implementation

## 1. Write the Product Brief

State the reader, task, decision, scope, exclusions, intended content type, accountable owner, sources, sensitivity, and success measure. Search for existing authority before creating a file. Extend the canonical product when its purpose matches; create a new one only when audience, lifecycle, ownership, or task differs materially.

## 2. Capture Source Evidence

For each material source record title, publisher/owner, direct location, version or publication/update date, access date, applicability, and any license or confidentiality constraint. Prefer current primary standards, official product documentation, authoritative policy, and verified system evidence. Separate facts, inference, recommendations, and organization-specific decisions.

Never copy credentials, tokens, personal data, customer data, confidential commercial terms, or live identifiers into a general knowledge repository. Replace them with explicit synthetic placeholders and preserve required constraints.

## 3. Author Canonically

Use the repository [metadata standard](../metadata-standards.md), [naming standard](../naming-standards.md), and [content lifecycle](../content-lifecycle.md). Write one authoritative explanation and link to it from learning paths, examples, and indexes. Use task-oriented headings, explicit prerequisites and boundaries, decision tables where choices repeat, failure/recovery guidance, and a worked example that changes more than labels.

Keep source Markdown coherent before chunking. Do not insert arbitrary fragment files merely to accommodate an embedding system.

## 4. Validate Before Publication

Automate checks for:

- required metadata and allowed values;
- internal links and anchors;
- duplicate normalized content and conflicting canonical claims;
- orphaned Active documents with no navigational inbound path;
- secret, credential, personal-data, and live-identifier patterns;
- file naming, scope, status, and ownership;
- source currency and version-dependent claims;
- accessibility, code/example validity, and rendering where applicable.

Human review verifies correctness, usefulness, provenance, judgment, and safety. A passing linter cannot establish those qualities.

## 5. Publish and Derive

Merge through review into the canonical store. Generate navigation, search indexes, embeddings, catalogs, or exports from that committed version. Record corpus/source revision, transformation, index/schema/embedding version, access policy, build time, and validation result. Fail publication closed if mandatory validation or permission propagation fails.

## 6. Supersede Safely

Link the old product to its replacement and the replacement back to the old authority. Update navigation and derived indexes. Archive or quarantine under repository policy; do not silently delete evidence or leave two Active authorities. Test important inbound links or create an explicit redirect/compatibility path where supported.
