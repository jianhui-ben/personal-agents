---
description: Ingest a source into your personal knowledge wiki — accepts a file path, URL, or inline text
argument-hint: "<file-path | https://url | inline note text>"
---

Dispatch the wiki agent to ingest: $ARGUMENTS

The wiki agent detects the input type and acts accordingly:
- **File path** — reads the file directly and synthesizes topic pages
- **URL** — fetches the content, saves to `wiki/raw/articles/`, synthesizes topic pages
- **Inline text** — saves to `wiki/raw/notes/YYYY-MM-DD-<slug>.md`, synthesizes topic pages

Then it will:
1. Discuss key findings with you
2. Update relevant wiki topic pages
3. Update `wiki/index.md`
4. Log the ingest to `wiki/log.md`

Examples:
```
/personal:wiki-ingest wiki/raw/articles/fastapi-guide.md
/personal:wiki-ingest https://example.com/some-paper
/personal:wiki-ingest "key insight from today: async Python is better than threading for I/O-bound tasks"
```
