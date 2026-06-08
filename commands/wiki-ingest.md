---
description: Ingest a source file into your personal knowledge wiki
argument-hint: "<path-to-source-file>"
---

Dispatch the wiki agent to ingest the source at: $ARGUMENTS

The wiki agent will:
1. Read the source
2. Discuss key findings with you
3. Update relevant wiki topic pages
4. Update `wiki/index.md`
5. Log the ingest to `wiki/log.md`

Example: `/personal:wiki-ingest wiki/raw/articles/fastapi-guide.md`
