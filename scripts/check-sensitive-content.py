#!/usr/bin/env python3
"""Detect high-confidence sensitive values without printing matched content."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from repository_quality import print_findings, repository_root, runtime_failure, scan_sensitive_content
except ModuleNotFoundError as exc:
    print(f"repository:1: configuration error: missing dependency '{exc.name}'; install requirements-dev.txt")
    raise SystemExit(2)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, help="repository root (defaults to the script parent)")
    args = parser.parse_args()
    try:
        root = repository_root(args.root, __file__)
        findings, checked = scan_sensitive_content(root)
        print_findings(findings)
        print(f"repository:1: summary: scanned {checked} text files; violations={len(findings)}; matched values always suppressed")
        return 1 if findings else 0
    except Exception as exc:  # pragma: no cover - defensive CLI boundary
        return runtime_failure(exc)


if __name__ == "__main__":
    raise SystemExit(main())
