---
title: Duplicate Content Report
description: Exact and near-duplicate groups identified before the repository reorganization.
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
  - duplicates
  - content-quality
related:
  - repository-audit.md
  - file-movement-map.csv
---

# Duplicate Content Report

## Method

The baseline scan compared raw SHA-256 hashes, normalized Markdown bodies, and token-set similarity. Exact hashes identify byte-for-byte duplicates. Normalized matches ignore front matter and insignificant formatting. Near-duplicate candidates require editorial review because similar vocabulary can be legitimate within related topics.

No file in this report is deleted automatically. Exact duplicate copies are archived, superseded sources remain intact, and uncertain candidates move to review-required.

## Exact Duplicate Groups

| Files | Similarity | Canonical document | Proposed action | Human review |
|---|---:|---|---|---|
| `01-architecture/manifest.json`; `manifest.json` | 100% | None; both are historical generation manifests | Archive both under historical generation, recording one as a duplicate | No |
| `02-data-engineering/README.md`; `02-data-engineering/index.md` | 100% | Domain `README.md` | Keep README; archive index duplicate | No |
| `03-analytics-bi/README.md`; `03-analytics-bi/index.md` | 100% | Domain `README.md` | Keep README; archive index duplicate | No |
| `04-ai-machine-learning/README.md`; `04-ai-machine-learning/index.md` | 100% | Domain `README.md` | Keep README; archive index duplicate | No |
| `05-automation/README.md`; `05-automation/index.md` | 100% | Domain `README.md` | Keep README; archive index duplicate | No |
| `06-software-engineering/README.md`; `06-software-engineering/index.md` | 100% | New domain READMEs after the software/DevOps split | Archive index duplicate | No |
| `07-cloud-devops/README.md`; `07-cloud-devops/index.md` | 100% | New Cloud Platforms and DevOps READMEs | Archive index duplicate | No |
| `08-governance-risk-controls/README.md`; `08-governance-risk-controls/index.md` | 100% | `09-security-governance/README.md` | Archive index duplicate | No |
| `09-business-context/README.md`; `09-business-context/index.md` | 100% | `10-business-domain/README.md` | Archive index duplicate | No |
| `10-quick-reference-sheets/README.md`; `10-quick-reference-sheets/index.md` | 100% | `13-reference/README.md` | Archive index duplicate | No |
| AI-governance example READMEs in the AI and governance domains | 100% | Governance-domain copy | Archive the AI-domain duplicate | No |

## Normalized Duplicate Groups

The domain README/index pair for Architecture is equivalent after ignoring its malformed front-matter delimiter. It receives the same README-canonical treatment as the exact pairs.

The AI-governance folders in `04-ai-machine-learning` and `08-governance-risk-controls` contain normalized duplicates for architecture, best practices, business context, examples, governance, learning, and troubleshooting. The canonical topic will be `09-security-governance/ai-governance/`; the AI domain will link to it.

## Cross-Domain Near Duplicates

The scan found extensive documents with identical token sets but topic substitutions. Representative groups include:

- Architecture overviews across CI/CD, monitoring, process design, data governance, AI governance, and business operations.
- Troubleshooting guides across CI/CD, monitoring, AI governance, and the centralized troubleshooting topic.
- Learning paths across CI/CD, AI governance, and centralized troubleshooting.
- Best-practice guides across CI/CD, testing, and AI governance.

### Recommended Treatment

1. Keep a document active only when it contains subject-specific decisions, examples, constraints, or authoritative references.
2. Move generic generated fragments to `95-review-required/generated-scaffolding/`, retaining their target-domain hierarchy.
3. If a fragment contains unique material, merge that material into the topic README or canonical guide and archive the original as superseded.
4. Do not merge merely because two files share a standard structure.

## Important Unique Content to Preserve

The following bespoke documents are not considered disposable scaffolding even when they overlap other guides:

- Power Automate repeatable solution patterns.
- Intelligent Automation repository operating model.
- API reference guide.
- Git reference guide.
- SQL and analytics guide.
- Claude platform guide.
- Power Platform connection-reference guide.
- Bulk-email worked example.
- Data-modeling and Databricks pattern guides.
- Applied-AI and UiPath pattern guides.
- Organization-specific Power Platform review and remediation backlog.

These documents will be moved, renamed, or split while preserving their technical detail.

## Review Queue Criteria

A duplicate candidate requires human review when:

- Similarity is high but both documents contain different examples or operational constraints.
- Ownership or intended audience differs.
- One document is organization-specific and the other is general guidance.
- Primary-source verification could change which document is authoritative.
- Consolidation would remove decision history or project evidence.
