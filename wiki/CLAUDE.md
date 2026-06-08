# Wiki Schema

This document defines conventions for the personal knowledge wiki.
**Read this before any wiki operation.**

## Directory Structure

```
wiki/
├── CLAUDE.md          # this file — schema and conventions
├── index.md           # catalog of all pages (LLM-maintained)
├── log.md             # append-only event log (LLM-maintained)
├── raw/
│   ├── articles/      # web articles clipped to markdown (immutable)
│   ├── notes/         # personal raw notes (immutable)
│   └── assets/        # images downloaded from clipped articles (immutable)
└── topics/
    ├── learning/      # personal learning topics
    ├── projects/      # per-project context and research findings
    └── reference/     # tools, libraries, patterns
```

Raw sources are immutable — read them, never modify them.

## Page Frontmatter

Every topic page must include:

```yaml
---
title: <topic name>
category: learning | project | reference
tags: [tag1, tag2]
last_updated: YYYY-MM-DD
sources: [source-slug-1, source-slug-2]
contradictions: []  # optional — list conflicting source slugs when contradiction detected
---
```

## Cross-References

Use `[[page-title]]` syntax for links between wiki pages. This is Obsidian-compatible.

## Naming Conventions

- Topic files: `wiki/topics/<category>/<kebab-case-title>.md`
- Source slugs: `<year>-<kebab-case-title>` (e.g. `2026-fastapi-async-guide`)

## Ingest Workflow

1. Read the source file (from `wiki/raw/`)
2. Discuss key takeaways with the user
3. Write or update topic pages in `wiki/topics/<category>/` — typically 5-15 pages per source
4. Add new pages to `wiki/index.md` under the correct category with a one-line summary
5. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | <source title>`

## Query Workflow

1. Read `wiki/index.md` to identify relevant pages
2. Read those pages
3. Synthesize an answer with citations to wiki pages and original sources
4. Offer to file the answer as a new wiki page — **ask the user before writing**
5. If filing: append `## [YYYY-MM-DD] query | <question summary>` to `wiki/log.md`

## Lint Checklist

Check for:
- **Contradictions**: pages making conflicting claims about the same topic
- **Stale claims**: claims that newer sources may have superseded (check `last_updated` dates)
- **Orphan pages**: pages with no inbound `[[links]]` from other pages
- **Missing pages**: concepts mentioned in `[[links]]` but lacking their own page
- **Missing cross-references**: pages that should link to each other but don't
- **Data gaps**: topics where more sources would significantly improve coverage

7. Append to `wiki/log.md`: `## [YYYY-MM-DD] lint | <N issues found, N fixed, key suggestions>`

## Contradiction Handling

When a new source contradicts an existing wiki claim:
1. Note the contradiction inline on the affected page
2. Add a `contradictions` frontmatter key listing the conflicting source slugs
3. Flag the page in the lint output for future review

## Deduplication

If the same concept appears under different names across sources, merge into the most canonical page. At the top of the deprecated page, add: `> Merged into [[canonical-page-title]]`. Update all inbound links. Set the deprecated page's `last_updated` to today's date and clear its `sources` list.
