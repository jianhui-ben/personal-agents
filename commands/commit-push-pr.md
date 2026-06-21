---
description: Commit all changes and open a GitHub PR
argument-hint: [branch-name] [pr-title]
allowed-tools: Bash(git:*), Bash(gh:*)
---

<!--
Usage: /commit-push-pr [branch-name] [pr-title]

  /commit-push-pr
  /commit-push-pr feat/add-login
  /commit-push-pr fix/null-check "Fix null pointer in auth flow"

branch-name — optional; auto-derived from diff if omitted (kebab-case, feat/fix/chore prefix)
pr-title    — optional; auto-derived from commit subject if omitted
-->

## Context

- Branch:  !`git branch --show-current`
- Changes: !`git status --porcelain | wc -l | tr -d ' '` file(s) modified
- Status:  !`git status`
- Diff:    !`git diff HEAD 2>/dev/null || git diff`
- Log:     !`git log --oneline -10`
- Remote:  !`git remote get-url origin 2>/dev/null || echo "(no remote)"`

## Arguments

$ARGUMENTS

## Task

**Guard — nothing to commit:** If Changes above is `0`, output "Nothing to commit — working tree is clean." and stop.

**Guard — no remote:** If Remote is `(no remote)`, output "No remote origin configured — cannot push." and stop.

Perform all steps in a **single message** with parallel tool calls where possible:

1. **Stage** — `git add -A` (skip if already fully staged)
2. **Branch** — if on `main` or `master`, create and switch to a new branch:
   - Use first token of `$ARGUMENTS` as branch name if it looks like `type/description`
   - Otherwise derive `feat/`, `fix/`, or `chore/` + kebab-case summary from the diff
3. **Commit** — pass message via heredoc to avoid quoting issues:
   - Subject: imperative mood, ≤72 chars
   - Blank line
   - 1–2 sentences on *why*, not what
   - Trailer: `Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>`
4. **Push** — `git push -u origin <branch>`
5. **PR** — `gh pr create` with body via heredoc:
   - Title: use quoted string from `$ARGUMENTS` if provided; otherwise reuse commit subject (≤70 chars)
   - Body:
     ```
     ## Summary
     - <bullet 1>
     - <bullet 2>

     ## Test plan
     - [ ] <manual check or automated test>

     🤖 Generated with [Claude Code](https://claude.com/claude-code)
     ```

Output only the PR URL when done.
