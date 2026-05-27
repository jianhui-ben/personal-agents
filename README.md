# personal-plugin

Personal Claude Code plugin. Loaded via `--plugin-dir` on every session.

## Setup

Add to `~/.zshrc`:

```zsh
alias claude='claude --plugin-dir ~/Projects/personal-agents --dangerously-skip-permissions'
```

Then reload:

```bash
source ~/.zshrc
```

## Agents

| Agent | Purpose |
|---|---|
| **coder** | Write, edit, debug, or refactor code |
| **researcher** | Find information from web, codebase, or data sources |
| **fact-checker** | Verify claims and cross-reference sources |
| **writer** | Produce docs, articles, tutorials, reports |
| **planner** | Break down goals, create roadmaps, design approach |
| **tester** | Write tests, evaluate coverage, run E2E validation |

Claude Code's main agent acts as orchestrator — invoke specialists by mentioning them or let Claude choose automatically.

## Commands

- `/personal:agents` — list all agents with examples

## Structure

```
agents/        # Specialist agents
commands/      # Slash commands (/personal:*)
hooks/         # Event-driven automation
skills/        # Future: personal behavior tuning
```
