---
title: Repository Audit
description: Baseline audit of the knowledge repository before the 2026 reorganization.
domain: Repository Management
subdomain: Repository Audits
content_type: Research Note
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Event-driven
tags:
  - repository-management
  - audit
  - knowledge-management
related:
  - duplicate-content-report.md
  - file-movement-map.csv
  - reorganization-report.md
---

# Repository Audit

## Executive Summary

The repository has strong subject breadth and consistently named Markdown files, but its active knowledge system is obscured by generated volume. The baseline contains 970 tracked files: 968 Markdown documents and two JSON manifests. All Markdown files have an H1 title, and the deepest tracked files are four levels below the root. There are no images, executable scripts, or continuous-integration workflows.

The principal problem is authority rather than naming. Sixty-nine topic folders repeat an eleven-document scaffold, 806 Markdown files receive no inbound navigation link, and most metadata uses generation-phase labels instead of lifecycle states. A small group of detailed, bespoke guides coexists with hundreds of generic drafts whose canonical status is unclear.

The reorganization will preserve all content, promote verified canonical documents, centralize reusable assets, and move uncertain generated scaffolding to a review area. No baseline file will be permanently deleted.

## Baseline Snapshot

| Measure | Result |
|---|---:|
| Baseline commit | `5d4e7074789bd0ad3ee0b985186d1e5c07045dc6` |
| Tracked files | 970 |
| Markdown files | 968 |
| JSON files | 2 |
| Top-level domain folders | 11 |
| Maximum file depth | 4 |
| Markdown files with valid front matter | 867 |
| Markdown files without front matter | 100 |
| Markdown files with malformed front matter | 1 |
| Markdown files with H1 titles | 968 |
| Topic folders containing the standard generated set | 69 |
| Markdown documents without inbound navigation | 806 |
| Exact duplicate groups | 11 |
| Exact duplicate files | 22 |
| Broken internal relative links detected | 0 |
| Images | 0 |
| Scripts and workflows | 0 |

## Current Top-Level Structure

```text
01-architecture/
02-data-engineering/
03-analytics-bi/
04-ai-machine-learning/
05-automation/
06-software-engineering/
07-cloud-devops/
08-governance-risk-controls/
09-business-context/
10-quick-reference-sheets/
99-templates/
```

The current structure is usable for subject browsing, but it combines cloud with DevOps, software engineering with delivery tooling, and governance with security. Reusable assets and organization-specific delivery documents are also mixed with general knowledge.

## Major Organizational Problems

1. **Generated volume hides authority.** Most topic folders contain the same filenames and document shapes regardless of whether the topic warrants each artifact.
2. **Canonical documents are not identified.** A reader cannot reliably distinguish a primary guide from a starter draft, phase draft, or overlapping quick reference.
3. **Navigation reaches folders, not documents.** Domain indexes link to topic READMEs, but most detailed documents are never linked from a README, map, or learning path.
4. **Metadata is structurally common but semantically weak.** The repository uses nine generation-oriented status labels. All 866 documents with a `level` field use `Beginner to Pro`, and 860 share `last_updated: 2026-06-20`.
5. **Relationships are non-specific.** In 788 documents, `related` contains only `../`, which resolves but does not help a reader choose the next document.
6. **Content types are physically mixed.** Long tutorials appear under quick-reference folders, examples are repeated under every topic, and prompts are nested under architecture templates.
7. **Cross-cutting disciplines are incomplete.** Reliability engineering, observability, platform engineering, FinOps, Microsoft Fabric, complete Power Platform architecture, production AI operations, and knowledge engineering lack canonical coverage.
8. **Organization-specific guidance is not distinguished.** The Power Platform review and remediation backlog contain implementation-specific observations but currently sit under general business context.

## Metadata Findings

Existing front matter commonly includes `title`, `domain`, `level`, `status`, `last_updated`, `tags`, and `related`, but it omits descriptions, content types, scope, owners, review cycles, and evidence of review.

The current status distribution is dominated by `Expanded Draft` (546 documents), followed by `Phase 3 Draft` (87), `Starter` (78), `Phase 3 Analytics/BI Draft` (66), and `Phase 2 Draft` (64). These values will be mapped to the controlled lifecycle: Draft, Active, Review Required, Superseded, or Archived.

The malformed front matter is in `01-architecture/README.md`, which begins with an opening delimiter but has no closing delimiter.

## Naming Findings

All non-README Markdown filenames and all folder names already use lowercase kebab-case. The inconsistency is semantic: repeated names such as `architecture-overview.md`, `reference-guide.md`, and `example-01.md` are only meaningful when their folder context is visible. Generic example names and the standalone `repository.md` require descriptive renaming.

Root-level `index.md` also differs from the planned uppercase navigation convention and will become `START-HERE.md`.

## Link and Asset Findings

The baseline internal relative-link scan found no unresolved targets. There are no tracked images, so there are no missing or unreferenced image findings. External URLs were not used as a baseline gate because network availability and vendor redirects are unstable; authoritative external references will be checked when a document is promoted to Active.

The absence of broken links does not imply adequate navigation: 806 Markdown documents have no inbound link from another Markdown document.

## Large and Fragmented Documents

The following large documents require structural review:

| Document | Approximate lines | Planned treatment |
|---|---:|---|
| `05-automation/intelligent-automation/repository.md` | 3,255 | Rename as an intelligent-automation repository operating model and retain as a canonical guide. |
| `06-software-engineering/api/README.md` | 2,890 | Convert to a concise entry point and split focused design, security, reliability, and implementation guides. |
| `10-quick-reference-sheets/commands/sql-cheat-sheet.md` | 2,637 | Move the tutorial to Data Engineering and derive a concise reference sheet. |
| `05-automation/power-automate/README.md` | 2,537 | Convert to navigation and split major implementation and operations sections. |
| `05-automation/power-automate/repeatable-patterns.md` | 2,485 | Retain the pattern library but index patterns by reliability concern. |
| `06-software-engineering/git/README.md` | 2,038 | Move to DevOps and split navigation from detailed Git guidance. |
| `04-ai-machine-learning/claude.md` | 2,024 | Move beneath AI platforms and split platform, API/tooling, governance, and operations concerns. |

Seventy-four Markdown files contain fewer than twenty nonblank lines. Most are generated example indexes or short templates. They will be preserved, but empty example indexes will be archived as incomplete and generic scaffolds will be quarantined for review.

## Duplicate-Content Candidates

The exact duplicate groups are documented in `duplicate-content-report.md`. Important cases include:

- Domain `README.md` and `index.md` pairs in nine domains.
- Root and architecture copies of `manifest.json`.
- AI governance documents duplicated between the AI and governance domains.
- Cross-domain near duplicates whose vocabulary is effectively identical after changing topic names.

## Security and Publication Findings

A non-disclosing scan checked 1,780 reachable blobs across all current Git history using high-confidence patterns for private keys, GitHub tokens, cloud access keys, JWTs, authorization headers, and literal secret assignments. No matches were found.

The current tree contains organization-specific review material and references historical credential exposure in source artifacts outside this repository. Those documents will remain public as requested, but will be clearly labeled organization-specific and will continue to avoid embedding credential values.

## Proposed Target Structure

```text
00-repository-guide/
01-enterprise-architecture/
02-software-engineering/
03-data-engineering/
04-analytics-bi/
05-automation/
06-artificial-intelligence/
07-cloud-platforms/
08-devops/
09-security-governance/
10-business-domain/
11-project-delivery/
12-templates/
13-reference/
14-learning-paths/
15-examples/
16-prompts/
90-inbox/
95-review-required/
99-archive/
repository-management/
scripts/
```

The detailed proposed disposition for every baseline file is recorded in `file-movement-map.csv`.

The movement map now records actual outcomes, and the completed results, validation evidence, residual warnings, and safe follow-up boundaries are documented in the [reorganization report](reorganization-report.md).

## Files Requiring Human Review

- Generated architecture, best-practice, business-context, framework, governance, and troubleshooting fragments whose topic-specific authority cannot be established automatically.
- Generic worked examples named `example-01.md` or `example-scenario.md`.
- Documents marked Starter or a phase-specific draft that contain useful but unverified claims.
- Organization-specific documents when their audience, continuing ownership, or publication status changes.
- Near-duplicate groups where each document contains unique operational context.

These files will be moved to `95-review-required/generated-scaffolding/` rather than deleted or silently merged.

## Reorganization Risks

| Risk | Mitigation |
|---|---|
| Large move obscures review | Use staged commits, `git mv`, and a complete movement CSV. |
| External links to old paths break | Preserve Git history and publish the movement map; do not create duplicate redirect copies. |
| Generic content is mistaken for verified guidance | Promote documents to Active only after primary-source verification. |
| Useful fragments are lost during consolidation | Archive superseded originals intact and record preserved unique material in the duplicate report. |
| Generated indexes drift | Generate only marked sections and enforce idempotent `--check` mode. |
| Public content exposes sensitive context | Run sensitive-content checks without printing values and label organization-specific material. |
| Cross-platform scripts fail on Windows | Use `pathlib`, UTF-8, no shell-specific path logic, and Windows-focused tests. |

## Recommended Implementation Sequence

1. Commit this baseline audit, duplicate report, and proposed movement map.
2. Establish navigation, taxonomy, lifecycle guidance, and domain entry points.
3. Execute moves and quarantine generated scaffolding.
4. Add the eight missing production-quality topic families.
5. Standardize metadata and cross-links for Active canonical content.
6. Add validation scripts, tests, and CI.
7. Update the movement map with actual outcomes and publish the reorganization report.
