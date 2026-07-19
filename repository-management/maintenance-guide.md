---
title: Repository Maintenance Guide
description: Practical workflow for safe content maintenance, deterministic indexes, validation evidence, and reversible Git changes.
domain: Repository Management
subdomain: Content Governance
content_type: Runbook
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-19
review_cycle: Annual
tags:
  - repository-management
  - maintenance
  - validation
related:
  - README.md
  - audits/reorganization-report.md
  - ../scripts/README.md
  - ../CONTRIBUTING.md
---

# Repository Maintenance Guide

## Purpose

Use this runbook for routine repository changes, lifecycle review, structural moves, generated-index updates, and recovery. It keeps Active authority explicit, preserved evidence intact, and every change reviewable through normal Git history.

## Maintenance Guardrails

- Update an existing canonical document instead of creating overlapping Active guidance.
- Use `git mv` for real moves and update relative links in the same change.
- Preserve baseline audits, movement records, archive material, and Review Required evidence unless a separately reviewed correction explains the change.
- Never promote product, policy, security, licensing, or platform behavior to Active without current official primary-source review.
- Keep organization-specific and project-specific content under `11-project-delivery/`, visibly scoped, and free of private identifiers or production personal data.
- Never commit credentials, tokens, authorization headers, private keys, or real secret values. Use documented placeholders only where a template requires them.
- Do not edit generated maps by hand. A write requires the explicit index command.
- Use Git revert for recovery; do not rewrite published history to hide a maintenance change.

## Routine Change Workflow

1. Start from a clean branch and inspect `git status --short --branch`.
2. Read the applicable domain README, repository standards, and existing canonical document.
3. Decide whether the change is Active guidance, Draft, Review Required evidence, a reusable asset, or archive material.
4. Make the smallest coherent change. Preserve source evidence and use `git mv` for path changes.
5. Update inbound navigation, explicit `related` paths, and the movement map when a tracked structural migration is involved.
6. If Active metadata changed, regenerate indexes explicitly and review only the generated map diff.
7. Run unit tests and all six quality commands.
8. Confirm validation did not change the checkout, review the complete diff, and commit one coherent outcome.
9. Re-run the critical checks from the committed tree or a fresh `git archive` extraction before publication.

## Environment Setup

The only development dependency is the pinned PyYAML version in `requirements-dev.txt`.

```powershell
python -m pip install --requirement requirements-dev.txt
```

An isolated virtual environment or temporary dependency directory is preferred when the workstation's Python environment is shared.

## Required Non-Writing Validation

Run these exact commands from the repository root:

```powershell
python -m unittest discover -s tests -p "test_*.py" -v
python scripts/check-frontmatter.py
python scripts/check-links.py
python scripts/find-duplicate-content.py
python scripts/find-orphaned-documents.py
python scripts/check-sensitive-content.py
python scripts/generate-indexes.py --check
```

A successful required run has no Active metadata, internal-link, Active-orphan, Active-duplicate, sensitive-value, or generated-index violations. Preserved non-Active warnings remain advisory.

For the wider legacy review surface, run:

```powershell
python scripts/check-frontmatter.py --show-warnings
python scripts/check-links.py --all
```

Do not normalize, link, promote, merge, or delete non-Active evidence only to make advisory totals smaller.

## Deterministic Index Operation

The three maps under `repository-management/maps/` are generated from Active metadata. Required validation is non-writing:

```powershell
python scripts/generate-indexes.py --check
```

When an intentional Active metadata or lifecycle change makes the maps stale, update them explicitly:

```powershell
python scripts/generate-indexes.py --write
python scripts/generate-indexes.py --check
git diff -- repository-management/maps
```

Run the write command a second time when proving idempotence. It must report `changed=0`.

## Review and Non-Writing Proof

Start and finish validation with a clean status check:

```powershell
git status --short
python -m unittest discover -s tests -p "test_*.py" -v
python scripts/check-frontmatter.py
python scripts/check-links.py
python scripts/find-duplicate-content.py
python scripts/find-orphaned-documents.py
python scripts/check-sensitive-content.py
python scripts/generate-indexes.py --check
git status --short
```

When the tree was clean before validation, the final status must also be empty. Before committing, also run:

```powershell
git diff --check
git diff --stat
git diff --name-status
```

## Committed-Object Review

Do not rely only on files left in the working directory. Inspect the committed object:

```powershell
git rev-parse HEAD
git rev-parse HEAD^
git show --stat --oneline --decorate HEAD
git diff --check HEAD^ HEAD
git ls-tree -r --name-only HEAD
git status --short --branch
```

For a fresh-tree audit on Windows, write the archive to a file before extraction; do not pipe binary archive bytes through PowerShell:

```powershell
$auditRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("knowledge-repository-audit-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $auditRoot | Out-Null
git archive -o (Join-Path $auditRoot "head.tar") HEAD
tar -xf (Join-Path $auditRoot "head.tar") -C $auditRoot
Set-Location $auditRoot
```

Install the development requirement in an isolated environment, then run the same test and validation commands in that extracted tree.

## Structural Changes and Movement Accounting

For a future large migration:

- Add one movement-map row for every source path before moving files.
- Keep `original_path` unique and preserve it as historical evidence.
- Record one actual `new_path`, action, reason, outcome status, and human-review decision per source.
- Verify every target exists and the source set still matches the audited baseline.
- Use a new audit or map for a materially different future baseline instead of overwriting the 2026 source record.

## Review Cadence

Use the review cycle in Active metadata:

- Quarterly for fast-moving security, AI, licensing, and product-limit guidance.
- Semiannual for platform implementation and operations guidance.
- Annual for stable concepts, architecture principles, and repository governance.
- Event-driven for audits, decisions, historical reports, and templates.

A file move or formatting edit is not evidence of technical review and must not advance `last_reviewed` by itself.

## Safe Revert Procedure

Inspect the target commit, then create a normal inverse commit:

```powershell
git switch codex/reorganize-knowledge-repository
git status --short --branch
git show --stat --oneline <commit-sha>
git revert --no-edit <commit-sha>
```

For a contiguous range that needs review before the revert commit is created:

```powershell
git revert --no-commit <oldest-commit-sha>^..<newest-commit-sha>
git diff --check
git diff --stat
git status --short
git commit -m "revert: undo repository maintenance changes"
```

If the range or conflict resolution is wrong, use `git revert --abort`. Destructive reset commands are excluded because they discard reviewable history and can lose unrelated work.
