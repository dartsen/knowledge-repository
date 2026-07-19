#!/usr/bin/env python3
"""Validate internal Markdown links and anchors without changing files."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from repository_quality import (
        authoritative_source_paths,
        check_links,
        iter_markdown_files,
        print_findings,
        repository_root,
        runtime_failure,
    )
except ModuleNotFoundError as exc:
    print(f"repository:1: configuration error: missing dependency '{exc.name}'; install requirements-dev.txt")
    raise SystemExit(2)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, help="repository root (defaults to the script parent)")
    parser.add_argument("--all", action="store_true", help="also validate preserved Draft, review, and archive documents")
    args = parser.parse_args()
    try:
        root = repository_root(args.root, __file__)
        paths = list(iter_markdown_files(root)) if args.all else authoritative_source_paths(root)
        findings, checked = check_links(root, paths)
        print_findings(findings)
        print(f"repository:1: summary: checked {checked} internal links from {len(paths)} documents; violations={len(findings)}")
        return 1 if findings else 0
    except Exception as exc:  # pragma: no cover - defensive CLI boundary
        return runtime_failure(exc)


if __name__ == "__main__":
    raise SystemExit(main())
