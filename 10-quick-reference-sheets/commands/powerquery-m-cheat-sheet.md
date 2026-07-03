---
title: Power Query M Language Cheat Sheet
domain: Quick Reference Sheets
level: Beginner to Pro
status: Active
last_updated: 2026-07-03
tags:
  - quick-reference-sheets
  - commands
  - power-query
  - m-language
  - analytics-bi
related:
  - ../
---

# Power Query (M Language) Cheat Sheet

> Quick reference for the M formula language used in Power Query (Power BI, Excel, Dataflows): query structure, data types, common transformations, and useful functions.

## How an M Query Is Structured

A query is a `let` expression: a series of named steps, each usually referencing the previous one, ending with an `in` result.

```mermaid
flowchart LR
    SRC["Source<br/>(connect)"] --> P["Promote headers /<br/>change types"]
    P --> F["Filter / remove rows"]
    F --> T["Transform columns"]
    T --> A["Aggregate / merge / append"]
    A --> OUT["in (final step)"]
```

## Basic Query Skeleton

```m
let
    Source = Excel.Workbook(File.Contents("C:\\data\\sales.xlsx"), null, true),
    Sheet1 = Source{[Item="Sheet1", Kind="Sheet"]}[Data],
    Promoted = Table.PromoteHeaders(Sheet1, [PromoteAllScalars=true]),
    Typed = Table.TransformColumnTypes(Promoted, {{"Amount", type number}, {"Date", type date}}),
    Filtered = Table.SelectRows(Typed, each [Amount] > 0)
in
    Filtered
```

## Data Types

| Type | Notes |
|---|---|
| `number` | Whole and decimal numbers |
| `text` | Strings (double-quoted) |
| `logical` | `true` / `false` |
| `date` / `time` / `datetime` / `datetimezone` | Temporal types |
| `duration` | Time span |
| `list` | `{1, 2, 3}` ordered values |
| `record` | `[Name="A", Age=1]` named fields |
| `table` | Rows and columns |
| `null` | Missing value |

## Accessing Data

| Syntax | Returns |
|---|---|
| `{0}` | First item of a list (zero-based) |
| `Table{5}` | Row 6 as a record |
| `[ColumnName]` | A column's value (in row context) |
| `Record[Field]` | A field from a record |
| `Table[Column]` | A column as a list |

## Common Table Transformations

| Function | Purpose |
|---|---|
| `Table.SelectRows(t, each cond)` | Filter rows |
| `Table.SelectColumns(t, {cols})` | Keep specific columns |
| `Table.RemoveColumns(t, {cols})` | Drop columns |
| `Table.RenameColumns(t, {{"old","new"}})` | Rename columns |
| `Table.AddColumn(t, "name", each expr)` | Add a calculated column |
| `Table.TransformColumnTypes(t, {...})` | Set column types |
| `Table.Group(t, {keys}, {aggs})` | Group and aggregate |
| `Table.Sort(t, {{"col", Order.Ascending}})` | Sort rows |
| `Table.Distinct(t)` | Remove duplicate rows |
| `Table.Join` / `Table.NestedJoin` | Merge tables |
| `Table.Combine({t1, t2})` | Append tables |
| `Table.Pivot` / `Table.Unpivot` | Reshape wide/long |

## Text Functions

| Function | Purpose |
|---|---|
| `Text.Upper` / `Text.Lower` / `Text.Proper` | Change case |
| `Text.Trim` / `Text.Clean` | Strip spaces / non-printables |
| `Text.Start(s, n)` / `Text.End(s, n)` | Leading / trailing chars |
| `Text.Middle(s, start, len)` | Substring |
| `Text.Replace(s, old, new)` | Replace text |
| `Text.Contains(s, sub)` | Boolean search |
| `Text.Split(s, delim)` | Split into a list |
| `Text.Combine(list, delim)` | Join a list |

## Number, Date & Logic

| Function / Operator | Purpose |
|---|---|
| `Number.Round(x, digits)` | Rounding |
| `Number.From(v)` / `Text.From(v)` | Type conversion |
| `Date.Year` / `Date.Month` / `Date.Day` | Extract date parts |
| `Date.AddDays(d, n)` | Date arithmetic |
| `if cond then a else b` | Conditional expression |
| `and` / `or` / `not` | Logical operators |
| `try expr otherwise fallback` | Error handling |

## Adding a Conditional Column

```m
Table.AddColumn(
    PreviousStep,
    "Tier",
    each if [Amount] >= 1000 then "High"
         else if [Amount] >= 100 then "Medium"
         else "Low",
    type text
)
```

## Common Mistakes & Fixes

- **Step names with spaces referenced without `#"..."`** — use `#"Changed Type"` for spaced identifiers.
- **Zero-based vs one-based confusion** — list/row indexing starts at `0`.
- **Case sensitivity** — M is case-sensitive for identifiers and `each` field names.
- **Hard-coded file paths** — parameterize with a query parameter for portability.
- **Forgetting type steps** — untyped columns break downstream sorting, math, and relationships.

## Red Flags

- Queries that break "query folding" early (kills source-side performance).
- Long chains of manual UI steps with no comments or renaming.
- Absolute local paths that won't work when published to a service.
- Repeated logic that should be a reusable custom function.

## Beginner-to-Pro Notes

| Level | Focus |
|---|---|
| Beginner | Use the UI; understand `let`/`in` and steps. |
| Advanced Beginner | Filter, rename, change types by hand in M. |
| Intermediate Practitioner | Custom columns, grouping, merges/appends. |
| Advanced Practitioner | Custom functions, error handling, parameters. |
| Enterprise Professional | Query folding, dataflows, performance. |
| Architect / Strategic Lead | Reusable function libraries, governance, standards. |
