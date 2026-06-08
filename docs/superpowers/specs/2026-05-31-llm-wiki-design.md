# LLM Wiki — Design Spec

**Date:** 2026-05-31
**Repo:** `~/Projects/personal-agents`

## Overview

Add a persistent, compounding knowledge wiki to the `personal-agents` plugin, based on Karpathy's LLM Wiki pattern. A dedicated `wiki` agent maintains a three-layer knowledge base — raw sources, synthesized wiki pages, and a schema — across personal learning, project research, and reference topics. Natural language and slash commands both trigger wiki operations. A weekly cron hook surfaces automated lint reminders.

## Goals

- Persistent knowledge that compounds across sessions (not rediscovered from scratch each time)
- Covers three knowledge types: personal learning, project research, reference
- Accessible via natural language ("what do I know about X") and slash commands
- Automated weekly lint reminder to keep the wiki healthy
- Hosted inside `personal-agents` so it's available in every Claude Code session

## Three-Layer Architecture

**Layer 1 — Raw sources** (`wiki/raw/`)
Immutable source documents the LLM reads but never modifies. Articles clipped from the web (via Obsidian Web Clipper), personal notes, and downloaded image assets. Source of truth.

**Layer 2 — The wiki** (`wiki/`)
LLM-generated markdown: summaries, entity pages, concept pages, syntheses. The wiki agent owns and writes this layer entirely. Organized by category (learning, projects, reference). Two special files: `index.md` (content catalog) and `log.md` (append-only event log).

**Layer 3 — The schema** (`wiki/CLAUDE.md`)
Configuration document that travels with the wiki. Defines conventions, page formats, frontmatter structure, and workflows for ingest/query/lint. Loaded by the wiki agent at the start of every operation so conventions are consistent across sessions.

## Repo Structure Changes

```
personal-agents/
├── agents/
│   └── wiki.md                  ← new specialist agent
├── commands/
│   ├── wiki-ingest.md           ← new
│   ├── wiki-query.md            ← new
│   └── wiki-lint.md             ← new
├── hooks/
│   └── hooks.json               ← updated: add weekly cron entry
└── wiki/
    ├── CLAUDE.md                ← wiki schema (conventions + workflows)
    ├── index.md                 ← catalog of all wiki pages
    ├── log.md                   ← append-only event log
    ├── raw/
    │   ├── articles/            ← web articles clipped to markdown
    │   ├── notes/               ← personal raw notes
    │   └── assets/              ← images downloaded from clipped articles
    └── topics/
        ├── learning/            ← personal learning topics
        ├── projects/            ← per-project context and findings
        └── reference/           ← tools, libraries, patterns
```

## The `wiki` Agent

**File:** `agents/wiki.md`

```yaml
name: wiki
model: sonnet
tools: Read, Write, Edit, Glob, Grep, WebFetch
description: Use when you need to manage your personal knowledge wiki — ingest sources, query accumulated knowledge, or maintain wiki health
```

The agent always reads `wiki/CLAUDE.md` first to load current conventions before any operation.

### Operations

**Ingest** — triggered by "add this to my wiki" or `/personal:wiki-ingest <path>`
1. Read the source file
2. Discuss key takeaways
3. Write or update relevant topic pages in `wiki/topics/`
4. Update `wiki/index.md`
5. Append an entry to `wiki/log.md`
A single source typically touches 5-15 wiki pages.

**Query** — triggered by "what do I know about X" or `/personal:wiki-query <question>`
1. Read `wiki/index.md` to find relevant pages
2. Read those pages
3. Synthesize an answer with citations
4. Offer to file the answer back as a new wiki page — ask the user before writing (valuable analyses shouldn't disappear into chat history)

**Lint** — triggered by "clean up my wiki" or `/personal:wiki-lint`
1. Scan all pages via index
2. Flag: contradictions, stale claims, orphan pages, missing cross-references, important concepts without their own page
3. Suggest new questions to investigate and new sources to look for

## Slash Commands

| Command | Usage | Purpose |
|---|---|---|
| `/personal:wiki-ingest` | `/personal:wiki-ingest raw/articles/foo.md` | Ingest a specific source |
| `/personal:wiki-query` | `/personal:wiki-query "what do I know about FastAPI"` | Query accumulated knowledge |
| `/personal:wiki-lint` | `/personal:wiki-lint` | Run a full wiki health check |

## Automated Lint Reminder

A cron entry in `hooks/hooks.json` fires every Monday at 9am and prints a reminder in the next Claude session to run `/personal:wiki-lint`. The agent does not run automatically — the cron surfaces the prompt, and the user confirms.

```json
{
  "cron": "0 9 * * 1",
  "command": "echo 'Weekly wiki lint due — run /personal:wiki-lint to keep your wiki healthy'"
}
```

## Wiki Page Format

Each topic page uses consistent YAML frontmatter:

```yaml
---
title: <topic name>
category: learning | project | reference
tags: [tag1, tag2]
last_updated: YYYY-MM-DD
sources: [source-slug-1, source-slug-2]
---
```

Cross-references use `[[wiki-links]]` (Obsidian-compatible).

## Log Format

Each log entry uses a consistent prefix for unix parseability:

```
## [YYYY-MM-DD] ingest | <source title>
## [YYYY-MM-DD] query | <question summary>
## [YYYY-MM-DD] lint | <summary of findings>
```

Example: `grep "^## \[" wiki/log.md | tail -5` shows the last 5 events.

## Wiki Schema (wiki/CLAUDE.md)

The schema document defines (to be co-evolved with the agent over time):
- Directory structure and naming conventions
- Page frontmatter fields and allowed values
- Ingest workflow steps
- Query workflow steps
- Lint checklist
- How to handle contradictions between sources
- How to handle duplicate concepts under different names

## Out of Scope

- Embedding-based vector search (index.md is sufficient at this scale)
- Batch ingestion without supervision
- Automated wiki edits without user confirmation
- MCP search server (can be added later via `qmd` if wiki grows large)
