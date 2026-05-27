# Personal Claude Code Plugin — Design Spec

**Date:** 2026-05-26
**Repo:** `~/Projects/personal-agents`

## Overview

Revamp the `personal-agents` repo into a proper Claude Code plugin. The plugin is loaded via `--plugin-dir` on every session, making all agents, commands, and hooks globally available across all projects.

## Goals

- 6 specialist agents available in every Claude Code session
- Claude Code's main agent acts as orchestrator (no dedicated Jarvis agent)
- A `/personal:agents` command for quick reference
- A `SessionStart` hook as a lightweight reminder
- Private GitHub repo, iterated over time

## Repo Structure

```
~/Projects/personal-agents/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── coder.md
│   ├── researcher.md
│   ├── fact-checker.md
│   ├── writer.md
│   ├── planner.md            (new)
│   └── tester.md             (new)
├── skills/                   (empty for now, future personal behavior tuning)
├── commands/
│   └── agents.md             (/personal:agents)
├── hooks/
│   └── session-start.sh
├── docs/
│   └── superpowers/specs/    (this file lives here)
├── README.md
└── .gitignore
```

**Removed:** `.claude/agents/` (old project-local agents), `scripts/` (unused launch scripts), `examples/`, `TMUX_SETUPS.md`

## Plugin Manifest

```json
{
  "name": "personal",
  "description": "Personal Claude Code plugin — agents, commands, and hooks",
  "author": {
    "name": "Ben"
  }
}
```

Plugin name `"personal"` means commands are namespaced as `/personal:*`.

## Agents

All agents live in `agents/`. Each is a markdown file with YAML frontmatter.

### coder
- **model:** sonnet
- **tools:** Read, Write, Edit, Bash, Glob, Grep
- **description:** Use when you need to write, edit, debug, or refactor code — implementation work that involves files
- **isolation:** worktree (keep existing setting)

### researcher
- **model:** sonnet
- **tools:** WebSearch, WebFetch, Read, Grep, Glob
- **description:** Use when you need to find information — searches the web, explores the codebase, and queries other data sources to gather and synthesize findings

### fact-checker
- **model:** sonnet
- **tools:** WebSearch, WebFetch, Read, Grep
- **description:** Use when you need to verify claims, validate accuracy, or cross-reference information against sources

### writer
- **model:** sonnet
- **tools:** Read, Write, Edit
- **description:** Use when you need to produce polished written output — docs, articles, tutorials, reports

### planner (new)
- **model:** sonnet
- **tools:** Read, Glob, Grep
- **description:** Use when you need to break down a complex goal into steps, create roadmaps, or design an approach before implementation

### tester (new)
- **model:** sonnet
- **tools:** Read, Write, Edit, Bash, Glob, Grep
- **description:** Use when you need to write tests, design test strategies, evaluate coverage, or run end-to-end tests to validate code changes

## Commands

### `/personal:agents`
Lists all available agents, their purpose, and example invocations. Reference card for when you forget what's available.

## Hooks

### `SessionStart`
Lightweight shell script. Prints a one-line reminder of available agents when a session opens.

## Local Setup

```zsh
# ~/.zshrc
alias claude='claude --plugin-dir ~/Projects/personal-agents --dangerously-skip-permissions'
```

This ensures every `claude` invocation — including `claude --resume <id>` from cmux restarts — loads the plugin automatically.

## Future Extensions

- `skills/` — personal behavior-shaping skills (code style preferences, workflow patterns)
- More commands — `/personal:standup`, `/personal:new-project`, `/personal:review`
- More hooks — PreToolUse guard rails, context loading
- More agents — as new specialist needs emerge
