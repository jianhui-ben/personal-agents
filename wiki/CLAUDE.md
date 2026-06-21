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
│   ├── articles/      # any written/text content: web articles, papers, PDFs exported to text
│   ├── notes/         # anything you wrote or transcribed: session notes, book highlights,
│   │                  #   course/lecture notes, YouTube transcripts, interview-prep notes
│   └── assets/        # any visual/binary files: images, screenshots, HTML diagrams,
│                      #   architecture recap pages
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

## Source Type Guide

How to get different content types into the wiki:

| Source type | How to ingest | Lands in |
|---|---|---|
| Web article / paper (URL) | `/personal:wiki-ingest https://...` | `raw/articles/` (auto-saved) |
| PDF paper | Paste key excerpts as markdown, then ingest the file | `raw/notes/` |
| Course / lecture notes | Take notes as you learn; ingest the file or type inline | `raw/notes/` |
| Book highlights | Export highlights as markdown; ingest the file | `raw/notes/` |
| YouTube video | Paste transcript or your notes; ingest inline or as file | `raw/notes/` |
| Session insight | `/personal:wiki-ingest "your insight here"` (inline text) | `raw/notes/` (auto-saved) |
| HTML diagram / screenshot | Save to `raw/assets/`; ingest the file path | `raw/assets/` |

For interview prep, use `learning/` category with tags like `[interview-prep, system-design, algorithms]`.

## Ingest Workflow

Detect the input type before reading:
- **File path**: read the file directly
- **URL**: WebFetch → save to `raw/articles/<year>-<slug>.md` → proceed
- **HTML file**: extract title, architecture description, component list, and any Mermaid source — the HTML is the visual, the wiki page is the queryable layer; frontmatter `sources:` references the HTML file path
- **Inline text**: save to `raw/notes/YYYY-MM-DD-<slug>.md` → proceed

Then:
1. Discuss key takeaways with the user
2. Write or update topic pages in `wiki/topics/<category>/` — typically 5-15 pages per source
3. Add new pages to `wiki/index.md` under the correct category with a one-line summary
4. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | <source title>`

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
