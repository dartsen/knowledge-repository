---
title: Navigation Guide
description: Navigation and canonicality rules for finding repository content without duplicating it.
domain: Repository Management
subdomain: Repository Navigation
content_type: Implementation Guide
level: Beginner
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Annual
tags:
  - navigation
  - canonical-content
  - discovery
related:
  - README.md
  - ../START-HERE.md
  - metadata-standards.md
---

# Navigation Guide

The repository supports multiple paths without duplicating documents.

## By Intent

Use `START-HERE.md` for learning, troubleshooting, implementation, governance, meetings, or design tasks.

## By Subject

Use the numbered domain folders. Each domain README identifies scope, canonical guides, related domains, learning sequence, patterns, operations, and governance.

## By Content Type

Use Templates, Reference, Learning Paths, Examples, and Prompts for reusable assets. These areas link back to the subject guide that explains context.

## By Search

Search YAML fields and tags. Useful queries include `status: Active`, `content_type: Runbook`, `scope: Organization-Specific`, and a technology tag.

## Canonicality

A document linked as an Important Document from its domain README, marked Active, and complete under the metadata standard is authoritative for its stated purpose. Draft and Review Required documents may still be useful, but must not silently override Active guidance. A `related` entry is a discovery aid, not a declaration that its target is canonical.
