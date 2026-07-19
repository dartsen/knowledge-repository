from __future__ import annotations

import datetime as dt
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS))

from repository_quality import (  # noqa: E402
    check_indexes,
    check_links,
    extract_markdown_links,
    find_duplicate_groups,
    find_orphans,
    markdown_anchors,
    parse_markdown,
    resolve_link_target,
    review_due_date,
    scan_sensitive_text,
    validate_active_document,
    write_indexes,
)


def active_document(title: str = "Test Guide", *, status: str = "Active", reviewed: str = "2026-01-31") -> str:
    return f"""---
title: {title}
description: A test document.
domain: Testing
subdomain: Quality
content_type: Concept Guide
level: Beginner
status: {status}
scope: General
owner: Repository Maintainer
last_reviewed: {reviewed}
review_cycle: Quarterly
tags:
  - testing
related:
  - README.md
---

# {title}

Substantive test content.
"""


class PathAndLinkTests(unittest.TestCase):
    def test_windows_separators_and_encoded_paths_resolve(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "docs" / "source.md"
            target = root / "docs" / "nested folder" / "target.md"
            target.parent.mkdir(parents=True)
            source.write_text("# Source\n", encoding="utf-8")
            target.write_text("# Target Heading\n", encoding="utf-8")
            resolved, fragment, problem = resolve_link_target(root, source, r"nested%20folder\target.md#target-heading")
            self.assertIsNone(problem)
            self.assertEqual(target.resolve(), resolved)
            self.assertEqual("target-heading", fragment)

    def test_links_images_and_duplicate_heading_anchors(self) -> None:
        targets = [link.target for link in extract_markdown_links("[Guide](docs/my%20guide.md#start) ![Image](assets/flow.png)")]
        self.assertEqual(["docs/my%20guide.md#start", "assets/flow.png"], targets)
        self.assertEqual({"repeat", "repeat-1"}, markdown_anchors("# Repeat\n## Repeat\n"))

    def test_link_checker_validates_encoded_anchor(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "README.md"
            target = root / "my guide.md"
            source.write_text("[Guide](my%20guide.md#start-here)\n", encoding="utf-8")
            target.write_text("# Start Here\n", encoding="utf-8")
            findings, checked = check_links(root, [source])
            self.assertEqual(1, checked)
            self.assertEqual([], findings)


class MetadataTests(unittest.TestCase):
    def test_malformed_yaml_reports_source_line(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = root / "broken.md"
            path.write_text("---\ntitle: [broken\n---\n# Broken\n", encoding="utf-8")
            parsed = parse_markdown(path, root)
            self.assertIsNotNone(parsed.error)
            self.assertGreaterEqual(parsed.error.line, 2)

    def test_invalid_lifecycle_value_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "README.md").write_text("# Root\n", encoding="utf-8")
            path = root / "guide.md"
            path.write_text(active_document(status="Published"), encoding="utf-8")
            parsed = parse_markdown(path, root)
            errors = validate_active_document(parsed, root, dt.date(2026, 2, 1))
            self.assertTrue(any("invalid status" in finding.message for finding in errors))

    def test_review_cycle_uses_calendar_months_and_flags_overdue(self) -> None:
        self.assertEqual(dt.date(2026, 4, 30), review_due_date(dt.date(2026, 1, 31), "Quarterly"))
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "README.md").write_text("# Root\n", encoding="utf-8")
            path = root / "guide.md"
            path.write_text(active_document(reviewed="2026-01-31"), encoding="utf-8")
            parsed = parse_markdown(path, root)
            errors = validate_active_document(parsed, root, dt.date(2026, 5, 1))
            self.assertTrue(any("review overdue" in finding.message for finding in errors))


class DuplicateAndOrphanTests(unittest.TestCase):
    def test_duplicate_active_bodies_fail(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "README.md").write_text("# Root\n", encoding="utf-8")
            (root / "one.md").write_text(active_document("Same"), encoding="utf-8")
            (root / "two.md").write_text(active_document("Same"), encoding="utf-8")
            errors, _warnings, _exact, _normalized = find_duplicate_groups(root)
            self.assertTrue(errors)

    def test_active_orphan_is_reported(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "README.md").write_text("# Root\n", encoding="utf-8")
            (root / "orphan.md").write_text(active_document("Orphan"), encoding="utf-8")
            errors, _non_active_orphans, _candidates = find_orphans(root)
            self.assertEqual(1, len(errors))
            self.assertIn("no inbound", errors[0].message)


class SensitiveContentTests(unittest.TestCase):
    def test_sensitive_value_is_suppressed_from_finding(self) -> None:
        value = "gh" + "p_" + ("A" * 30)
        findings = scan_sensitive_text("C:/repo/docs/configuration.md", "token=" + value)
        self.assertEqual(1, len(findings))
        output = findings[0].render()
        self.assertNotIn(value, output)
        self.assertIn("C:/repo/docs/configuration.md:1", output)
        self.assertIn("value suppressed", output)

    def test_placeholder_is_not_sensitive(self) -> None:
        self.assertEqual([], scan_sensitive_text("guide.md", "api_key=YOUR_API_KEY_PLACEHOLDER"))


class IndexTests(unittest.TestCase):
    def test_write_is_idempotent_and_check_is_current(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "README.md").write_text("# Root\n", encoding="utf-8")
            (root / "guide.md").write_text(active_document(), encoding="utf-8")
            first = write_indexes(root)
            second = write_indexes(root)
            self.assertEqual(3, len(first))
            self.assertEqual([], second)
            self.assertEqual([], check_indexes(root))

    def test_exactly_six_command_entrypoints_are_defined(self) -> None:
        expected = {
            "check-links.py",
            "check-frontmatter.py",
            "find-orphaned-documents.py",
            "find-duplicate-content.py",
            "generate-indexes.py",
            "check-sensitive-content.py",
        }
        entrypoints = {
            path.name
            for path in SCRIPTS.glob("*.py")
            if path.read_text(encoding="utf-8").startswith("#!/usr/bin/env python3")
        }
        self.assertEqual(expected, entrypoints)


if __name__ == "__main__":
    unittest.main()
