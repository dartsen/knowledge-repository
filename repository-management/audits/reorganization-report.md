---
title: Repository Reorganization Report
description: Final outcome, acceptance evidence, residual review work, and follow-up boundaries for the 2026 repository reorganization.
domain: Repository Management
subdomain: Repository Audits
content_type: Research Note
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-19
review_cycle: Event-driven
tags:
  - repository-management
  - reorganization
  - audit
related:
  - repository-audit.md
  - file-movement-map.csv
  - ../maintenance-guide.md
  - ../../scripts/README.md
---

# Repository Reorganization Report

## Executive Outcome

The reorganization is complete at the documentation and local validation stage. The work started from baseline commit `5d4e7074789bd0ad3ee0b985186d1e5c07045dc6`, retained every baseline file through a one-to-one movement record, preserved Git history, separated canonical guidance from review and archive material, and added the planned production-engineering knowledge families and repository quality controls.

This report covers repository structure, maintenance, and validation only. It does not revise product, platform, licensing, security-policy, or other current technical claims. Active technical claims remain tied to the official-source reviews accepted in the earlier content-family commits.

## Scope and Guardrails

The reorganization followed these boundaries:

- Preserve all 970 baseline source records and their Git history.
- Use a single actual target for every baseline source path.
- Move uncertain generated content to Review Required instead of promoting or deleting it.
- Preserve superseded, duplicate, and historical-generation evidence under Archive.
- Keep organization-specific records public-safe, visibly scoped, and separate from general guidance.
- Add no credentials, production personal data, tenant identifiers, private endpoints, or confidential case details.
- Generate indexes only from Active metadata and only through an explicit write command.

## Baseline Accounting and Movement Outcomes

The [movement map](file-movement-map.csv) now records actual outcomes rather than planned states. Its 970 data rows contain 970 unique `original_path` values and 970 unique `new_path` values; every recorded target exists.

| Source action | Rows | Actual outcome |
|---|---:|---|
| `move` | 301 | Target move completed. |
| `keep` | 17 | Source retained at its intended target path. |
| `move-and-split` | 6 | Move and structural split completed; the source record remains flagged for human authority review. |
| `rename` | 2 | Rename completed at the recorded target. |
| `review` | 619 | Content preserved under `95-review-required/generated-scaffolding/`; human review remains open. |
| `archive` | 25 | Twelve records are Archived and thirteen are Superseded at their recorded targets. |
| **Total** | **970** | **Every baseline source is accounted for exactly once.** |

The resulting `outcome_status` distribution is 326 Completed, 619 Review Required, 13 Superseded, and 12 Archived. The `human_review_required` flag remains true for 625 records: the 619 generated-scaffolding records and the six large moved-and-split source records.

## Major Structural Outcomes

- Replaced the mixed baseline domains with distinct architecture, engineering, data, analytics, automation, AI, cloud, DevOps, security/governance, business, delivery, and reusable-asset areas.
- Centralized templates, references, learning paths, worked examples, and prompts without duplicating their canonical subject guidance.
- Moved generic generated fragments to `95-review-required/generated-scaffolding/` while keeping their source-to-target accounting intact.
- Preserved duplicate domain indexes, superseded AI-governance material, and generation manifests under `99-archive/`.
- Separated organization-specific delivery evidence under `11-project-delivery/` and retained Review Required scope where publication authority or continuing ownership needs confirmation.
- Added deterministic Active-content maps by domain, content type, and tag under `repository-management/maps/`.

## Eight-Family Acceptance Matrix

Each core linked below contains an Active entry point plus Active architecture, implementation, operations, security/governance, troubleshooting, and official-reference documents. Each family also has an Active centralized learning path and Active worked example.

| Family | Canonical core | Central learning path | Worked example |
|---|---|---|---|
| Reliability and observability | [Reliability](../../08-devops/reliability-engineering/README.md) and [observability](../../08-devops/observability/README.md) | [Reliability and observability](../../14-learning-paths/devops/reliability-observability.md) | [Reliable and observable order API](../../15-examples/devops/reliable-order-api.md) |
| Integration engineering | [Integration architecture](../../01-enterprise-architecture/integration-architecture/README.md) | [Integration engineering](../../14-learning-paths/enterprise-architecture/integration-architecture.md) | [Resilient partner integration](../../15-examples/enterprise-architecture/resilient-partner-integration.md) |
| Platform engineering | [Platform engineering](../../08-devops/platform-engineering/README.md) | [Platform engineering](../../14-learning-paths/devops/platform-engineering.md) | [Self-service web-service platform](../../15-examples/devops/self-service-web-service-platform.md) |
| FinOps | [FinOps](../../09-security-governance/finops/README.md) | [FinOps](../../14-learning-paths/security-governance/finops.md) | [Technology cost allocation](../../15-examples/security-governance/technology-cost-allocation.md) |
| Microsoft Fabric | [Microsoft Fabric](../../03-data-engineering/microsoft-fabric/README.md) | [Microsoft Fabric](../../14-learning-paths/data-engineering/microsoft-fabric.md) | [Fabric sales lakehouse](../../15-examples/data-engineering/fabric-sales-lakehouse.md) |
| Microsoft Power Platform | [Microsoft Power Platform](../../05-automation/power-platform/README.md) | [Microsoft Power Platform](../../14-learning-paths/automation/power-platform.md) | [Employee onboarding solution](../../15-examples/automation/power-platform/employee-onboarding-solution.md) |
| AI production engineering | [AI production engineering](../../06-artificial-intelligence/production-engineering/README.md) | [AI production engineering](../../14-learning-paths/artificial-intelligence/production-engineering.md) | [Grounded support assistant](../../15-examples/artificial-intelligence/grounded-support-assistant.md) |
| Knowledge engineering | [Knowledge engineering](../../00-repository-guide/knowledge-engineering/README.md) | [Knowledge engineering](../../14-learning-paths/reference/knowledge-engineering.md) | [Canonical knowledge family](../../15-examples/reference/canonical-knowledge-family.md) |

The final family-matrix check verifies the required paths and `status: Active` directly. No family content was changed by this reporting commit.

## Final Validation Record

The final committed-object audit records the exact commit identifier separately. The results below are populated from the commit-9 candidate after the report and indexes are present.

| Check | Result |
|---|---|
| Unit tests | 12 passed, 0 failed |
| Active metadata and review dates | 122 checked, 277 preserved non-Active legacy warnings, 0 violations |
| Internal paths and heading anchors | 1,244 checked from 132 authoritative sources, 0 violations |
| Active orphan detection | 122 Active checked, 0 violations; 301 of 336 preserved non-Active canonical-area documents remain advisory orphans |
| Active duplicate detection | 0 violating Active groups; 1 exact and 7 normalized-equivalent non-Active groups remain warnings |
| Sensitive-content scan | 1,125 text files, 0 findings; matched values are suppressed |
| Deterministic generated indexes | Explicit write updated 3 maps; repeat write reported `changed=0`; non-writing check passed |
| Non-writing validation proof | 0 tracked hash changes after tests and all six command checks |
| Baseline movement accounting | 970 rows, 970 unique sources, 970 unique targets, zero missing targets |
| Eight-family matrix | 8 families, 79 required artifacts Active, 0 missing or non-Active paths |

## Known Non-Gating Warnings and Human Review

The following conditions are intentionally preserved and are not Active-authority failures:

- 619 generated-scaffolding records remain Review Required because subject-specific authority cannot be established mechanically.
- Six large moved-and-split source records remain flagged for human review even though their structural split is complete.
- 277 preserved non-Active documents continue to produce legacy metadata warnings; they are reported but do not override Active guidance.
- 301 of 336 preserved non-Active canonical-area documents remain orphaned until they are reviewed, archived, or linked from an appropriate non-authoritative surface.
- One exact and seven normalized-equivalent duplicate groups containing only non-Active content remain evidence for later editorial decisions.
- The wider `check-links.py --all` advisory scan checks 2,160 links from 1,112 documents and reports 502 unresolved links in preserved non-Active review/archive material, primarily legacy `../` metadata after moves. The authoritative Active/navigation surface remains clean.
- Repository-wide external URL availability is not a deterministic gate. Current product and policy guidance is instead promoted to Active only after primary-source review.

Use `python scripts/check-frontmatter.py --show-warnings` and `python scripts/check-links.py --all` for the wider advisory view. Do not promote, merge, or delete warning records solely to reduce a count.

## Risks and Safe Follow-Up Work

| Risk | Safe follow-up |
|---|---|
| Consumers retain links to baseline paths | Use the movement map to locate the target and update the external reference; do not recreate duplicate redirect documents. |
| Review material is mistaken for current guidance | Keep Review Required content out of Active navigation and generated indexes until an owner verifies scope, sources, and lifecycle. |
| Split legacy guides contain stale claims | Review the six flagged source families in small batches and promote only verified documents with controlled metadata. |
| Active claims age after publication | Follow each document's review cycle and trigger event-driven review when an official source or product behavior changes. |
| Generated indexes drift | Run index check on every change and use `--write` only when an intentional Active metadata change requires regeneration. |
| Archive or review evidence is accidentally rewritten | Treat baseline audit, movement, duplicate, review, and archive content as preserved evidence unless a separate change explicitly documents the correction. |

## Exact Review Commands

Run from the repository root in PowerShell:

```powershell
python -m pip install --requirement requirements-dev.txt
python -m unittest discover -s tests -p "test_*.py" -v
python scripts/check-frontmatter.py
python scripts/check-links.py
python scripts/find-duplicate-content.py
python scripts/find-orphaned-documents.py
python scripts/check-sensitive-content.py
python scripts/generate-indexes.py --check
git diff --check
git status --short
```

When Active metadata is intentionally added or changed, refresh and review the maps explicitly:

```powershell
python scripts/generate-indexes.py --write
python scripts/generate-indexes.py --check
git diff -- repository-management/maps
```

## Safe Revert Commands

Use a normal Git revert so history and review evidence remain intact:

```powershell
git switch codex/reorganize-knowledge-repository
git log --oneline --decorate -10
git revert --no-edit <commit-sha>
```

To prepare a reviewable revert of a contiguous range without committing immediately:

```powershell
git revert --no-commit <oldest-commit-sha>^..<newest-commit-sha>
git diff --check
git status --short
git commit -m "revert: undo repository reorganization changes"
```

If conflict resolution should be abandoned, use `git revert --abort`. Destructive reset commands are intentionally excluded.

For the ongoing operating procedure, use the [repository maintenance guide](../maintenance-guide.md).
