---
title: Knowledge Engineering Troubleshooting
description: Diagnostic runbook for findability, authority, provenance, staleness, links, indexing, and retrieval failures.
domain: Repository Management
subdomain: Knowledge Engineering
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - knowledge-troubleshooting
  - search-quality
  - content-quality
related:
  - operations.md
  - official-references.md
---

# Knowledge Engineering Troubleshooting

## First Capture

Record reader task, query or inbound link, expected product, actual result, canonical path and commit/version, status/owner/review date, source versions, classification, index/corpus/build version, caller authorization class, UTC time, and recent content or pipeline changes. Do not copy sensitive query or document content into a general ticket.

## Decision Table

| Symptom | Isolate | Safe response |
|---|---|---|
| Reader cannot find known content | Navigation path, vocabulary/synonym, title/headings, metadata, index freshness | Add a canonical link or term; rebuild only after validating source state |
| Two documents claim authority | Scope, owner, status, source, history, inbound links | Choose authority through review; link and archive/quarantine the other |
| Guidance is stale | Review date, source update, product lifecycle, owner gap | Mark warning or withdraw; assign review; avoid silent date-only refresh |
| Broken internal link | Move/rename history, case, relative path, generated index | Repair canonical target and inbound links; preserve compatibility if justified |
| Metadata validation fails | Schema/version, required field, allowed value, front matter parse | Quarantine publication; correct source; regenerate derivative |
| Active document is orphaned | Domain README, learning path, example/reference links | Add an intentional inbound path or reconsider status/placement |
| Search index misses new content | Build failure, filter, unsupported format, ACL, tombstone, index version | Compare canonical commit to manifest; rebuild bounded index; run known queries |
| Search returns withdrawn content | Tombstone/delete failure, cache, old corpus, alias | Disable affected index/alias, purge derivatives, verify across permission classes |
| Grounded answer cites wrong section | Chunk identity, source revision, ranking, citation assembly | Return source-only results; restore stable IDs; re-evaluate retrieval and answer |
| Unauthorized content appears | ACL ingestion/propagation, cache key, prefilter, export | Disable delivery, preserve evidence, invoke security/privacy incident process |
| Source conflict is hidden | Synthesis removed applicability/version context | Restore explicit conflict and decision record; re-review downstream guidance |
| Duplicate checker flags template text | Normalization too broad, legitimate shared metadata | Tune check with documented exclusions; still review substantive duplicate claims |

## Layered Diagnosis

Check canonical source, metadata/provenance, navigation, publication manifest, index contents, ranking/filter, delivery UI/API, and generated answer in that order. A visible answer can be wrong even when retrieval is correct, and an index can be correct while its alias or cache is stale.

## Escalation Evidence

Include a minimal reproducible query/link, canonical and derived version IDs, permission class, expected/actual source IDs, validation output, impact, containment, and owner. For possible exposure, poisoning, or unsafe operational guidance, stop distribution before attempting broad reindexing.
