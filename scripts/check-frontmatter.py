#!/usr/bin/env python3
"""Validate Active YAML metadata, controlled values, links, and review dates."""

from __future__ import annotations

import argparse
import datetime as dt
from pathlib import Path

try:
    from repository_quality import print_findings, repository_root, runtime_failure, validate_frontmatter
except ModuleNotFoundError as exc:
    print(f"repository:1: configuration error: missing dependency '{exc.name}'; install requirements-dev.txt")
    raise SystemExit(2)


def iso_date(value: str) -> dt.date:
    try:
        return dt.date.fromisoformat(value)
    except ValueError as exc:
        raise argparse.ArgumentTypeError("expected YYYY-MM-DD") from exc


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, help="repository root (defaults to the script parent)")
    parser.add_argument("--as-of", type=iso_date, default=dt.date.today(), help="review evaluation date (YYYY-MM-DD)")
    parser.add_argument("--show-warnings", action="store_true", help="list preserved non-Active legacy metadata warnings")
    args = parser.parse_args()
    try:
        root = repository_root(args.root, __file__)
        errors, warnings, active_count = validate_frontmatter(root, args.as_of)
        if args.show_warnings:
            print_findings(warnings)
        print_findings(errors)
        print(
            f"repository:1: summary: checked {active_count} Active documents as of {args.as_of.isoformat()}; "
            f"warnings={len(warnings)}; violations={len(errors)}"
        )
        return 1 if errors else 0
    except Exception as exc:  # pragma: no cover - defensive CLI boundary
        return runtime_failure(exc)


if __name__ == "__main__":
    raise SystemExit(main())
