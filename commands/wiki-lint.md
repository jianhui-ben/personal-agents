---
description: Run a health check on your personal knowledge wiki
---

Dispatch the wiki agent to lint the wiki.

The wiki agent will scan all pages and flag:
- Contradictions between pages
- Stale claims superseded by newer sources
- Orphan pages with no inbound links
- Missing pages for concepts mentioned in links
- Missing cross-references
- Data gaps worth investigating

It will also suggest new sources and questions to explore.

Example: `/personal:wiki-lint`
