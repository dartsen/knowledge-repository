"""Shared, read-only repository quality primitives.

The six command scripts in this directory use this module so path resolution,
front-matter parsing, diagnostics, and lifecycle rules stay consistent.
"""

from __future__ import annotations

import calendar
import datetime as dt
import hashlib
import html
import os
import posixpath
import re
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Iterator, Mapping, Sequence
from urllib.parse import quote, unquote, urlsplit

import yaml


REQUIRED_FIELDS = (
    "title",
    "description",
    "domain",
    "subdomain",
    "content_type",
    "level",
    "status",
    "scope",
    "owner",
    "last_reviewed",
    "review_cycle",
    "tags",
    "related",
)

CONTENT_TYPES = {
    "Overview",
    "Concept Guide",
    "Architecture Guide",
    "Pattern Guide",
    "Implementation Guide",
    "SOP",
    "Runbook",
    "Troubleshooting Guide",
    "Quick Reference",
    "Cheat Sheet",
    "Learning Path",
    "Example",
    "Template",
    "Prompt",
    "Decision Record",
    "Meeting Guide",
    "Research Note",
}
LEVELS = {"Beginner", "Intermediate", "Advanced", "Beginner to Pro", "All Levels"}
STATUSES = {"Draft", "Active", "Review Required", "Superseded", "Archived"}
SCOPES = {"General", "Organization-Specific", "Project-Specific"}
REVIEW_CYCLES = {"Quarterly", "Semiannual", "Annual", "Event-driven"}

ROOT_NAVIGATION = {"README.md", "START-HERE.md", "CONTRIBUTING.md", "CHANGELOG.md"}
LIFECYCLE_PREFIXES = {"90-inbox", "95-review-required", "99-archive"}
GENERATED_MAP_DIR = Path("repository-management/maps")
IGNORED_PARTS = {".git", ".venv", ".qa-deps", "__pycache__", "node_modules"}

INDEX_FILES = {
    "active-content-by-domain.md": "domain",
    "active-content-by-type.md": "content_type",
    "active-content-by-tag.md": "tags",
}


@dataclass(frozen=True)
class Finding:
    path: str
    line: int
    message: str
    severity: str = "error"

    def render(self) -> str:
        return f"{self.path}:{self.line}: {self.severity}: {self.message}"


@dataclass(frozen=True)
class ParsedMarkdown:
    path: Path
    text: str
    metadata: Mapping[str, object] | None
    body: str
    body_start_line: int
    error: Finding | None = None


@dataclass(frozen=True)
class MarkdownLink:
    target: str
    line: int


@dataclass(frozen=True)
class IndexedDocument:
    path: str
    title: str
    description: str
    domain: str
    content_type: str
    tags: tuple[str, ...]


def repository_root(value: str | Path | None, script_file: str | Path) -> Path:
    root = Path(value).resolve() if value else Path(script_file).resolve().parents[1]
    if not root.is_dir():
        raise ValueError(f"repository root does not exist: {root}")
    return root


def relative_path(path: Path, root: Path) -> str:
    try:
        return path.resolve().relative_to(root.resolve()).as_posix()
    except ValueError:
        return path.as_posix()


def iter_repository_files(root: Path, suffixes: set[str] | None = None) -> Iterator[Path]:
    files: list[Path] = []
    for path in root.rglob("*"):
        if not path.is_file() or any(part in IGNORED_PARTS for part in path.relative_to(root).parts):
            continue
        if suffixes is not None and path.suffix.lower() not in suffixes:
            continue
        files.append(path)
    yield from sorted(files, key=lambda item: item.relative_to(root).as_posix().casefold())


def iter_markdown_files(root: Path) -> Iterator[Path]:
    yield from iter_repository_files(root, {".md", ".markdown"})


def read_utf8(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig")


def parse_markdown(path: Path, root: Path) -> ParsedMarkdown:
    text = read_utf8(path)
    lines = text.splitlines()
    rel = relative_path(path, root)
    if not lines or lines[0].strip() != "---":
        return ParsedMarkdown(path, text, None, text, 1)

    closing = next((index for index in range(1, len(lines)) if lines[index].strip() == "---"), None)
    if closing is None:
        error = Finding(rel, 1, "front matter opens without a closing delimiter")
        return ParsedMarkdown(path, text, None, text, 1, error)

    source = "\n".join(lines[1:closing])
    try:
        loaded = yaml.safe_load(source)
    except yaml.YAMLError as exc:
        mark = getattr(exc, "problem_mark", None)
        line = (mark.line + 2) if mark is not None else 2
        problem = getattr(exc, "problem", None) or "invalid YAML"
        error = Finding(rel, line, f"malformed YAML front matter: {problem}")
        return ParsedMarkdown(path, text, None, "\n".join(lines[closing + 1 :]), closing + 2, error)

    if loaded is None:
        loaded = {}
    if not isinstance(loaded, dict):
        error = Finding(rel, 2, "front matter must be a YAML mapping")
        return ParsedMarkdown(path, text, None, "\n".join(lines[closing + 1 :]), closing + 2, error)

    body = "\n".join(lines[closing + 1 :])
    if text.endswith(("\n", "\r")):
        body += "\n"
    return ParsedMarkdown(path, text, loaded, body, closing + 2)


def metadata_line(text: str, key: str) -> int:
    pattern = re.compile(rf"^{re.escape(key)}\s*:", re.MULTILINE)
    match = pattern.search(text)
    return text.count("\n", 0, match.start()) + 1 if match else 1


def active_documents(root: Path) -> list[ParsedMarkdown]:
    documents: list[ParsedMarkdown] = []
    for path in iter_markdown_files(root):
        parsed = parse_markdown(path, root)
        if parsed.metadata and parsed.metadata.get("status") == "Active":
            documents.append(parsed)
    return documents


def is_lifecycle_path(path: Path, root: Path) -> bool:
    parts = path.relative_to(root).parts
    return bool(parts and parts[0] in LIFECYCLE_PREFIXES)


def is_generated_map(path: Path, root: Path) -> bool:
    try:
        path.relative_to(root / GENERATED_MAP_DIR)
        return True
    except ValueError:
        return False


def authoritative_source_paths(root: Path, *, include_generated: bool = True) -> list[Path]:
    selected = {parsed.path for parsed in active_documents(root)}
    for name in ROOT_NAVIGATION:
        candidate = root / name
        if candidate.exists():
            selected.add(candidate)
    organization_specific = root / "11-project-delivery" / "organization-specific"
    if organization_specific.exists():
        selected.update(iter_markdown_files(organization_specific))
    scripts_readme = root / "scripts" / "README.md"
    if scripts_readme.exists():
        selected.add(scripts_readme)
    if include_generated and (root / GENERATED_MAP_DIR).exists():
        selected.update(iter_markdown_files(root / GENERATED_MAP_DIR))
    return sorted(selected, key=lambda item: relative_path(item, root).casefold())


_INLINE_LINK = re.compile(r"!?\[[^\]\n]*\]\(([^)\n]+)\)")
_REFERENCE_LINK = re.compile(r"^\s*\[[^\]\n]+\]:\s*(\S+)")
_FENCE = re.compile(r"^\s*(```+|~~~+)")


def _clean_link_destination(raw: str) -> str:
    value = html.unescape(raw.strip())
    if value.startswith("<") and ">" in value:
        return value[1 : value.index(">")]
    title = re.match(r"^(\S+?)(?:\s+[\"'].*)?$", value)
    return title.group(1) if title else value


def extract_markdown_links(text: str) -> list[MarkdownLink]:
    links: list[MarkdownLink] = []
    in_fence = False
    fence_marker = ""
    for line_number, raw_line in enumerate(text.splitlines(), 1):
        fence = _FENCE.match(raw_line)
        if fence:
            marker = fence.group(1)[0]
            if not in_fence:
                in_fence, fence_marker = True, marker
            elif marker == fence_marker:
                in_fence, fence_marker = False, ""
            continue
        if in_fence:
            continue
        line = re.sub(r"`[^`]*`", "", raw_line)
        for match in _INLINE_LINK.finditer(line):
            links.append(MarkdownLink(_clean_link_destination(match.group(1)), line_number))
        reference = _REFERENCE_LINK.match(line)
        if reference:
            links.append(MarkdownLink(_clean_link_destination(reference.group(1)), line_number))
    return links


def metadata_related_links(parsed: ParsedMarkdown) -> list[MarkdownLink]:
    if not parsed.metadata:
        return []
    related = parsed.metadata.get("related")
    if not isinstance(related, list):
        return []
    result: list[MarkdownLink] = []
    lines = parsed.text.splitlines()
    start = metadata_line(parsed.text, "related")
    cursor = start
    for item in related:
        if not isinstance(item, str):
            continue
        found = next(
            (number for number in range(cursor, min(len(lines), parsed.body_start_line - 1) + 1) if item in lines[number - 1]),
            start,
        )
        result.append(MarkdownLink(item, found))
        cursor = found + 1
    return result


def _destination_and_fragment(target: str) -> tuple[str, str]:
    destination, separator, fragment = target.partition("#")
    destination = destination.split("?", 1)[0]
    return unquote(destination), unquote(fragment) if separator else ""


def resolve_link_target(root: Path, source: Path, target: str) -> tuple[Path | None, str, str | None]:
    value = target.strip()
    if not value:
        return source, "", None
    if re.match(r"^[A-Za-z]:[\\/]", value):
        return None, "", "absolute Windows paths are not portable repository links"
    if value.startswith("//"):
        return None, "", None
    parsed_url = urlsplit(value)
    if parsed_url.scheme:
        return None, "", None

    destination, fragment = _destination_and_fragment(value)
    destination = destination.replace("\\", "/")
    if not destination:
        candidate = source
    elif destination.startswith("/"):
        candidate = root.joinpath(*[part for part in destination.split("/") if part])
    else:
        candidate = source.parent.joinpath(*[part for part in destination.split("/") if part])

    candidate = candidate.resolve()
    try:
        candidate.relative_to(root.resolve())
    except ValueError:
        return candidate, fragment, "link resolves outside the repository"
    if candidate.is_dir():
        candidate = candidate / "README.md"
    elif not candidate.exists() and not candidate.suffix and (candidate / "README.md").exists():
        candidate = candidate / "README.md"
    return candidate, fragment, None


def github_slug(value: str) -> str:
    text = html.unescape(re.sub(r"<[^>]+>", "", value)).strip().lower()
    text = re.sub(r"[`*_~]", "", text)
    text = re.sub(r"[^\w\- ]", "", text, flags=re.UNICODE)
    return re.sub(r"\s+", "-", text)


def markdown_anchors(text: str) -> set[str]:
    anchors: set[str] = set()
    counts: dict[str, int] = defaultdict(int)
    in_fence = False
    fence_marker = ""
    for raw_line in text.splitlines():
        fence = _FENCE.match(raw_line)
        if fence:
            marker = fence.group(1)[0]
            if not in_fence:
                in_fence, fence_marker = True, marker
            elif marker == fence_marker:
                in_fence, fence_marker = False, ""
            continue
        if in_fence:
            continue
        for explicit in re.finditer(r"(?:id|name)=[\"']([^\"']+)[\"']", raw_line, re.IGNORECASE):
            anchors.add(explicit.group(1))
        heading = re.match(r"^\s{0,3}#{1,6}\s+(.+?)\s*#*\s*$", raw_line)
        if not heading:
            continue
        base = github_slug(heading.group(1))
        if not base:
            continue
        count = counts[base]
        anchors.add(base if count == 0 else f"{base}-{count}")
        counts[base] += 1
    return anchors


def check_links(root: Path, paths: Sequence[Path]) -> tuple[list[Finding], int]:
    findings: list[Finding] = []
    checked = 0
    anchors: dict[Path, set[str]] = {}
    for source in paths:
        parsed = parse_markdown(source, root)
        links = extract_markdown_links(parsed.text) + metadata_related_links(parsed)
        for link in links:
            target, fragment, problem = resolve_link_target(root, source, link.target)
            if target is None and problem is None:
                continue
            checked += 1
            rel = relative_path(source, root)
            if problem:
                findings.append(Finding(rel, link.line, problem))
                continue
            assert target is not None
            if not target.exists():
                findings.append(Finding(rel, link.line, f"missing internal target: {link.target}"))
                continue
            if fragment and target.suffix.lower() in {".md", ".markdown"}:
                if target not in anchors:
                    anchors[target] = markdown_anchors(read_utf8(target))
                if fragment not in anchors[target] and fragment.lower() not in anchors[target]:
                    findings.append(Finding(rel, link.line, f"missing anchor '#{fragment}' in {relative_path(target, root)}"))
    return findings, checked


def add_months(value: dt.date, months: int) -> dt.date:
    month_index = value.month - 1 + months
    year = value.year + month_index // 12
    month = month_index % 12 + 1
    day = min(value.day, calendar.monthrange(year, month)[1])
    return dt.date(year, month, day)


def review_due_date(reviewed: dt.date, cycle: str) -> dt.date | None:
    if cycle == "Quarterly":
        return add_months(reviewed, 3)
    if cycle == "Semiannual":
        return add_months(reviewed, 6)
    if cycle == "Annual":
        return add_months(reviewed, 12)
    return None


def coerce_date(value: object) -> dt.date | None:
    if isinstance(value, dt.datetime):
        return value.date()
    if isinstance(value, dt.date):
        return value
    if isinstance(value, str):
        try:
            return dt.date.fromisoformat(value)
        except ValueError:
            return None
    return None


def validate_active_document(parsed: ParsedMarkdown, root: Path, as_of: dt.date) -> list[Finding]:
    rel = relative_path(parsed.path, root)
    findings: list[Finding] = []
    if parsed.error:
        return [parsed.error]
    if parsed.metadata is None:
        return [Finding(rel, 1, "Active document is missing YAML front matter")]
    metadata = parsed.metadata
    keys = list(metadata)
    if keys[: len(REQUIRED_FIELDS)] != list(REQUIRED_FIELDS):
        findings.append(Finding(rel, 2, f"Active metadata fields must begin in this order: {', '.join(REQUIRED_FIELDS)}"))
    for field in REQUIRED_FIELDS:
        if field not in metadata:
            findings.append(Finding(rel, 2, f"missing required Active metadata field '{field}'"))

    scalar_fields = ("title", "description", "domain", "subdomain", "owner")
    for field in scalar_fields:
        value = metadata.get(field)
        if not isinstance(value, str) or not value.strip():
            findings.append(Finding(rel, metadata_line(parsed.text, field), f"'{field}' must be a nonempty string"))

    controlled = {
        "content_type": CONTENT_TYPES,
        "level": LEVELS,
        "status": STATUSES,
        "scope": SCOPES,
        "review_cycle": REVIEW_CYCLES,
    }
    for field, allowed in controlled.items():
        value = metadata.get(field)
        if value not in allowed:
            findings.append(Finding(rel, metadata_line(parsed.text, field), f"invalid {field} value '{value}'"))
    if metadata.get("status") != "Active":
        findings.append(Finding(rel, metadata_line(parsed.text, "status"), "Active validator received a non-Active document"))

    for field in ("tags", "related"):
        value = metadata.get(field)
        if not isinstance(value, list) or not value or not all(isinstance(item, str) and item.strip() for item in value):
            findings.append(Finding(rel, metadata_line(parsed.text, field), f"'{field}' must be a nonempty list of strings"))

    reviewed = coerce_date(metadata.get("last_reviewed"))
    if reviewed is None:
        findings.append(Finding(rel, metadata_line(parsed.text, "last_reviewed"), "last_reviewed must use YYYY-MM-DD"))
    else:
        due = review_due_date(reviewed, str(metadata.get("review_cycle")))
        if due is not None and as_of > due:
            findings.append(Finding(rel, metadata_line(parsed.text, "last_reviewed"), f"review overdue since {due.isoformat()}"))

    related = metadata.get("related")
    if isinstance(related, list):
        seen: set[str] = set()
        for item in related:
            if not isinstance(item, str):
                continue
            normalized = item.replace("\\", "/")
            line = next((link.line for link in metadata_related_links(parsed) if link.target == item), metadata_line(parsed.text, "related"))
            if normalized in seen:
                findings.append(Finding(rel, line, f"duplicate related target: {item}"))
            seen.add(normalized)
            target, _fragment, problem = resolve_link_target(root, parsed.path, item)
            if problem:
                findings.append(Finding(rel, line, problem))
            elif target is None or not target.exists():
                findings.append(Finding(rel, line, f"missing related target: {item}"))
            elif target.resolve() == parsed.path.resolve():
                findings.append(Finding(rel, line, "related target must not point to the document itself"))

    scope = metadata.get("scope")
    rel_parts = parsed.path.relative_to(root).parts
    if scope in {"Organization-Specific", "Project-Specific"}:
        if not rel_parts or rel_parts[0] != "11-project-delivery":
            findings.append(Finding(rel, metadata_line(parsed.text, "scope"), f"{scope} content must be under 11-project-delivery"))
        if not re.search(r"scope notice", parsed.body, re.IGNORECASE):
            findings.append(Finding(rel, parsed.body_start_line, f"{scope} content requires a visible scope notice"))
    return findings


def validate_frontmatter(root: Path, as_of: dt.date) -> tuple[list[Finding], list[Finding], int]:
    errors: list[Finding] = []
    warnings: list[Finding] = []
    active_count = 0
    for path in iter_markdown_files(root):
        parsed = parse_markdown(path, root)
        rel = relative_path(path, root)
        if parsed.metadata and parsed.metadata.get("status") == "Active":
            active_count += 1
            errors.extend(validate_active_document(parsed, root, as_of))
        elif parsed.error and not is_lifecycle_path(path, root):
            warnings.append(Finding(rel, parsed.error.line, parsed.error.message, "warning"))
        elif parsed.metadata:
            status = parsed.metadata.get("status")
            if status in STATUSES:
                continue
            if not is_lifecycle_path(path, root):
                warnings.append(Finding(rel, metadata_line(parsed.text, "status"), f"non-Active legacy status '{status}' is not a controlled value", "warning"))
    return errors, warnings, active_count


def find_orphans(root: Path) -> tuple[list[Finding], int, int]:
    active = {parsed.path.resolve(): parsed for parsed in active_documents(root)}
    inbound: dict[Path, int] = defaultdict(int)
    sources = authoritative_source_paths(root, include_generated=False)
    for source in sources:
        parsed = parse_markdown(source, root)
        for link in extract_markdown_links(parsed.text) + metadata_related_links(parsed):
            target, _fragment, problem = resolve_link_target(root, source, link.target)
            if problem or target is None or not target.exists() or target.resolve() == source.resolve():
                continue
            inbound[target.resolve()] += 1

    errors: list[Finding] = []
    for path in sorted(active, key=lambda item: relative_path(item, root).casefold()):
        if inbound[path] == 0:
            errors.append(Finding(relative_path(path, root), 1, "Active document has no inbound authoritative navigation link"))

    non_active_candidates = 0
    non_active_orphans = 0
    for path in iter_markdown_files(root):
        resolved = path.resolve()
        rel = path.relative_to(root)
        if resolved in active or is_lifecycle_path(path, root) or is_generated_map(path, root) or rel.as_posix() in ROOT_NAVIGATION:
            continue
        non_active_candidates += 1
        if inbound[resolved] == 0:
            non_active_orphans += 1
    return errors, non_active_orphans, non_active_candidates


def normalized_markdown_body(parsed: ParsedMarkdown) -> str:
    body = re.sub(r"<!--.*?-->", " ", parsed.body, flags=re.DOTALL)
    body = re.sub(r"\s+", " ", body).strip().casefold()
    return body


def find_duplicate_groups(root: Path) -> tuple[list[Finding], list[Finding], int, int]:
    parsed_by_path = {path: parse_markdown(path, root) for path in iter_markdown_files(root)}
    active = {path for path, parsed in parsed_by_path.items() if parsed.metadata and parsed.metadata.get("status") == "Active"}
    exact: dict[str, list[Path]] = defaultdict(list)
    normalized: dict[str, list[Path]] = defaultdict(list)
    for path, parsed in parsed_by_path.items():
        exact[hashlib.sha256(path.read_bytes()).hexdigest()].append(path)
        body = normalized_markdown_body(parsed)
        if body:
            normalized[hashlib.sha256(body.encode("utf-8")).hexdigest()].append(path)

    errors: list[Finding] = []
    warnings: list[Finding] = []
    exact_sets: set[frozenset[Path]] = set()
    exact_count = 0
    normalized_count = 0
    for group in exact.values():
        if len(group) < 2:
            continue
        exact_count += 1
        group_set = frozenset(group)
        exact_sets.add(group_set)
        paths = sorted(relative_path(path, root) for path in group)
        active_count = sum(path in active for path in group)
        severity = "error" if active_count > 1 else "warning"
        finding = Finding(paths[0], 1, f"exact duplicate group: {', '.join(paths)}", severity)
        (errors if severity == "error" else warnings).append(finding)

    for group in normalized.values():
        if len(group) < 2 or frozenset(group) in exact_sets:
            continue
        normalized_count += 1
        paths = sorted(relative_path(path, root) for path in group)
        active_count = sum(path in active for path in group)
        severity = "error" if active_count > 1 else "warning"
        finding = Finding(paths[0], 1, f"normalized-equivalent Markdown group: {', '.join(paths)}", severity)
        (errors if severity == "error" else warnings).append(finding)
    return errors, warnings, exact_count, normalized_count


def _sensitive_patterns() -> tuple[tuple[str, re.Pattern[str]], ...]:
    private_header = re.escape("-" * 5 + "BEGIN ") + r"(?:RSA |EC |OPENSSH )?PRIVATE KEY" + re.escape("-" * 5)
    return (
        ("private-key", re.compile(private_header)),
        ("github-token", re.compile(r"\bgh" + r"[pousr]_[A-Za-z0-9]{20,}\b")),
        ("aws-access-key", re.compile(r"\b(?:AKIA|ASIA)[A-Z0-9]{16}\b")),
        ("jwt", re.compile(r"\beyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\b")),
        ("bearer-token", re.compile(r"(?i)\bauthorization\s*:\s*bearer\s+[A-Za-z0-9._~+/=-]{16,}")),
        ("azure-account-key", re.compile(r"(?i)\baccountkey\s*=\s*[A-Za-z0-9+/]{40,}={0,2}")),
        (
            "literal-secret-assignment",
            re.compile(r"(?i)\b(?:password|client[_ -]?secret|api[_ -]?key|access[_ -]?token)\b\s*[:=]\s*[\"']?[A-Za-z0-9+/_=.~-]{20,}"),
        ),
    )


SENSITIVE_SUFFIXES = {".md", ".markdown", ".py", ".yml", ".yaml", ".json", ".csv", ".txt", ".toml", ".ini", ".cfg", ".ps1", ".sh"}


def _looks_like_placeholder(line: str) -> bool:
    lowered = line.casefold()
    markers = ("placeholder", "redacted", "replace_me", "replace-me", "your_api_key", "your-api-key", "example_value")
    return any(marker in lowered for marker in markers)


def scan_sensitive_text(path: str, text: str) -> list[Finding]:
    """Scan text while retaining only detector metadata, never the matched value."""
    findings: list[Finding] = []
    patterns = _sensitive_patterns()
    for line_number, line in enumerate(text.splitlines(), 1):
        if _looks_like_placeholder(line):
            continue
        for detector, pattern in patterns:
            if pattern.search(line):
                findings.append(Finding(path, line_number, f"possible sensitive value detected ({detector}); value suppressed"))
    return findings


def scan_sensitive_content(root: Path) -> tuple[list[Finding], int]:
    findings: list[Finding] = []
    checked = 0
    for path in iter_repository_files(root):
        if path.suffix.lower() not in SENSITIVE_SUFFIXES and path.name not in {"requirements-dev.txt"}:
            continue
        data = path.read_bytes()
        if b"\x00" in data:
            continue
        try:
            text = data.decode("utf-8-sig")
        except UnicodeDecodeError:
            continue
        checked += 1
        findings.extend(scan_sensitive_text(relative_path(path, root), text))
    return findings, checked


def _markdown_label(value: str) -> str:
    return value.replace("\\", "\\\\").replace("[", "\\[").replace("]", "\\]")


def _markdown_target(relative: str) -> str:
    return "/".join(quote(part, safe="-._~") for part in relative.split("/"))


def indexed_documents(root: Path) -> list[IndexedDocument]:
    documents: list[IndexedDocument] = []
    for parsed in active_documents(root):
        if is_generated_map(parsed.path, root):
            continue
        metadata = parsed.metadata or {}
        tags = metadata.get("tags") if isinstance(metadata.get("tags"), list) else []
        documents.append(
            IndexedDocument(
                path=relative_path(parsed.path, root),
                title=str(metadata.get("title", "")),
                description=str(metadata.get("description", "")),
                domain=str(metadata.get("domain", "")),
                content_type=str(metadata.get("content_type", "")),
                tags=tuple(str(tag) for tag in tags),
            )
        )
    return sorted(documents, key=lambda item: (item.title.casefold(), item.path.casefold()))


def _render_grouped_index(title: str, group_label: str, groups: Mapping[str, Sequence[IndexedDocument]]) -> str:
    lines = [
        "<!-- Generated by scripts/generate-indexes.py. Do not edit by hand. -->",
        f"# {title}",
        "",
        "This index is generated deterministically from Active document metadata.",
        "",
    ]
    for group in sorted(groups, key=str.casefold):
        lines.extend([f"## {group_label}: {group}", ""])
        for item in sorted(groups[group], key=lambda value: (value.title.casefold(), value.path.casefold())):
            relative = posixpath.relpath(item.path, GENERATED_MAP_DIR.as_posix())
            lines.append(f"- [{_markdown_label(item.title)}]({_markdown_target(relative)}) - {item.description}")
        lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def render_indexes(root: Path) -> dict[str, str]:
    documents = indexed_documents(root)
    by_domain: dict[str, list[IndexedDocument]] = defaultdict(list)
    by_type: dict[str, list[IndexedDocument]] = defaultdict(list)
    by_tag: dict[str, list[IndexedDocument]] = defaultdict(list)
    for document in documents:
        by_domain[document.domain].append(document)
        by_type[document.content_type].append(document)
        for tag in document.tags:
            by_tag[tag].append(document)
    return {
        "active-content-by-domain.md": _render_grouped_index("Active Content by Domain", "Domain", by_domain),
        "active-content-by-type.md": _render_grouped_index("Active Content by Type", "Content type", by_type),
        "active-content-by-tag.md": _render_grouped_index("Active Content by Tag", "Tag", by_tag),
    }


def check_indexes(root: Path) -> list[Finding]:
    findings: list[Finding] = []
    for name, expected in render_indexes(root).items():
        path = root / GENERATED_MAP_DIR / name
        rel = (GENERATED_MAP_DIR / name).as_posix()
        if not path.exists():
            findings.append(Finding(rel, 1, "generated index is missing; run generate-indexes.py --write"))
        elif path.read_text(encoding="utf-8-sig") != expected:
            findings.append(Finding(rel, 1, "generated index is stale; run generate-indexes.py --write"))
    return findings


def write_indexes(root: Path) -> list[str]:
    destination = root / GENERATED_MAP_DIR
    destination.mkdir(parents=True, exist_ok=True)
    changed: list[str] = []
    for name, content in render_indexes(root).items():
        path = destination / name
        current = path.read_text(encoding="utf-8-sig") if path.exists() else None
        if current != content:
            path.write_text(content, encoding="utf-8", newline="\n")
            changed.append((GENERATED_MAP_DIR / name).as_posix())
    return changed


def print_findings(findings: Iterable[Finding]) -> None:
    for finding in findings:
        print(finding.render())


def runtime_failure(exc: Exception) -> int:
    print(f"repository:1: runtime error: {type(exc).__name__}: {exc}")
    return 2
