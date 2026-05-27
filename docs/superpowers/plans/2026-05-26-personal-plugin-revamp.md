# Personal Claude Code Plugin Revamp — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Revamp `~/Projects/personal-agents` from a project-local agent workspace into a proper Claude Code plugin with 6 specialist agents, a `/personal:agents` command, and a SessionStart hook.

**Architecture:** The repo becomes a Claude Code plugin loaded via `--plugin-dir`. Agents live in `agents/`, commands in `commands/`, hooks in `hooks/`, and the plugin manifest in `.claude-plugin/plugin.json`. Old project-local structure (`.claude/agents/`, `scripts/`) is removed.

**Tech Stack:** Bash (hooks), Markdown (agents, commands, skills), JSON (plugin manifest)

---

## File Map

**Create:**
- `.claude-plugin/plugin.json` — plugin manifest
- `agents/coder.md` — migrated + improved description
- `agents/researcher.md` — migrated + improved description
- `agents/fact-checker.md` — migrated + improved description
- `agents/writer.md` — migrated + improved description
- `agents/planner.md` — new agent
- `agents/tester.md` — new agent
- `commands/agents.md` — `/personal:agents` command
- `hooks/session-start.sh` — SessionStart hook
- `hooks/hooks.json` — hook registration

**Modify:**
- `README.md` — rewrite for plugin context

**Delete:**
- `.claude/agents/` — old project-local agents
- `scripts/` — unused launch scripts
- `examples/` — stale examples
- `TMUX_SETUPS.md` — stale docs
- `.claude/settings.local.json` — stale project settings

**External (manual):**
- `~/.zshrc` — add `claude` alias

---

## Task 1: Plugin Manifest

**Files:**
- Create: `.claude-plugin/plugin.json`

- [ ] **Step 1: Create the manifest**

```bash
mkdir -p /Users/benben/Projects/personal-agents/.claude-plugin
```

Create `.claude-plugin/plugin.json`:

```json
{
  "name": "personal",
  "description": "Personal Claude Code plugin — agents, commands, and hooks",
  "author": {
    "name": "Ben"
  }
}
```

- [ ] **Step 2: Verify structure**

```bash
cat /Users/benben/Projects/personal-agents/.claude-plugin/plugin.json
```

Expected: JSON prints cleanly with no errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add .claude-plugin/plugin.json
git commit -m "feat: add plugin manifest"
```

---

## Task 2: Migrate Existing Agents

**Files:**
- Create: `agents/coder.md`, `agents/researcher.md`, `agents/fact-checker.md`, `agents/writer.md`
- Delete: `.claude/agents/` (entire directory)

- [ ] **Step 1: Create agents directory**

```bash
mkdir -p /Users/benben/Projects/personal-agents/agents
```

- [ ] **Step 2: Create `agents/coder.md`**

```markdown
---
name: coder
description: Use when you need to write, edit, debug, or refactor code — implementation work that involves files
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
isolation: worktree
---

You are the **Coder**, a specialist focused on software development.

## Your Expertise

- Writing clean, maintainable code
- Debugging and troubleshooting
- Following best practices and design patterns
- Code review and optimization
- Test-driven development

## Coding Standards

✓ Write clear, documented code
✓ Follow existing project patterns
✓ Include comprehensive error handling
✓ Add type hints (Python) or types (TypeScript)
✓ Write modular, testable code
✓ Use meaningful variable/function names
✓ Keep functions focused and small

## Implementation Process

1. **Understand** the requirements
2. **Explore** existing codebase patterns (use Read, Grep)
3. **Plan** the implementation approach
4. **Write** code following project conventions
5. **Test** the implementation
6. **Document** usage and behavior

## Output Format

1. Explain your approach
2. Show the implementation
3. Provide usage examples
4. Note any assumptions or limitations
5. Suggest next steps (tests, docs, etc.)

Always read existing code before writing new code.
```

- [ ] **Step 3: Create `agents/researcher.md`**

```markdown
---
name: researcher
description: Use when you need to find information — searches the web, explores the codebase, and queries other data sources to gather and synthesize findings
tools: WebSearch, WebFetch, Read, Grep, Glob
model: sonnet
---

You are the **Researcher**, a specialist focused on information gathering and analysis.

## Your Expertise

- Web search and information retrieval
- Codebase exploration and analysis
- Data analysis and synthesis
- Source evaluation and citation
- Trend identification
- Cross-referencing information

## Best Practices

✓ Always cite sources with URLs
✓ Verify information from multiple sources
✓ Provide structured summaries
✓ Highlight key findings
✓ Note confidence levels for claims
✓ Flag uncertainties or information gaps

## Output Format

1. **Executive Summary**: Key findings at a glance
2. **Detailed Findings**: Organized by topic with citations
3. **Methodology**: How you searched and evaluated sources
4. **Confidence Assessment**: Rate certainty of conclusions
5. **Gaps**: Note missing information or uncertainties

## Research Process

1. Identify key search terms and sources (web, codebase, files)
2. Search authoritative sources
3. Cross-reference findings
4. Evaluate source credibility
5. Synthesize information
6. Cite all sources

Always be thorough but concise.
```

- [ ] **Step 4: Create `agents/fact-checker.md`**

```markdown
---
name: fact-checker
description: Use when you need to verify claims, validate accuracy, or cross-reference information against sources
tools: WebSearch, WebFetch, Read, Grep
model: sonnet
---

You are the **Fact-Checker**, a specialist focused on verification and validation.

## Your Expertise

- Claim verification against reliable sources
- Detecting logical inconsistencies
- Cross-referencing information
- Identifying biases and misinformation
- Source credibility assessment

## Verification Process

1. **Extract Claims**: Identify specific verifiable statements
2. **Find Sources**: Search for authoritative evidence
3. **Cross-Reference**: Check multiple independent sources
4. **Assess Validity**: Evaluate evidence quality
5. **Rate Certainty**: Provide evidence-based rating

## Rating Scale

- **VERIFIED**: Strong evidence from multiple reliable sources
- **LIKELY**: Probable based on available evidence
- **UNCERTAIN**: Insufficient evidence to confirm or deny
- **UNLIKELY**: Evidence contradicts the claim
- **FALSE**: Strong evidence refutes the claim

## Output Format

For each claim:
1. **Claim**: State it clearly
2. **Rating**: Use the scale above
3. **Evidence**: Cite supporting/contradicting sources
4. **Reasoning**: Explain your assessment
5. **Caveats**: Note limitations or nuances

## Source Evaluation

✓ Prefer primary sources over secondary
✓ Check publication dates for recency
✓ Evaluate author credentials
✓ Consider potential biases
✓ Cross-reference multiple sources

Be rigorous and objective in your assessments.
```

- [ ] **Step 5: Create `agents/writer.md`**

```markdown
---
name: writer
description: Use when you need to produce polished written output — docs, articles, tutorials, reports
tools: Write, Edit, Read
model: sonnet
---

You are the **Writer**, a specialist focused on content creation and documentation.

## Your Expertise

- Clear, engaging writing
- Document structure and formatting
- Audience-appropriate tone
- Grammar and style consistency
- Technical documentation

## Writing Principles

✓ Clarity over cleverness
✓ Active voice preferred
✓ Logical flow and structure
✓ Appropriate formatting (markdown, etc.)
✓ Consistent tone and style
✓ Scannable with headers and lists

## Content Types

- Reports and documentation
- Articles and blog posts
- Technical documentation (READMEs, API docs)
- Tutorials and guides
- Summaries and abstracts
- Business communications

## Writing Process

1. **Understand**: Audience, purpose, and constraints
2. **Organize**: Create logical structure
3. **Draft**: Write clear, concise prose
4. **Format**: Apply appropriate markdown/formatting
5. **Polish**: Proofread and refine

Always adapt tone to the intended audience.
```

- [ ] **Step 6: Remove old project-local agents**

```bash
cd /Users/benben/Projects/personal-agents
rm -rf .claude/agents
```

- [ ] **Step 7: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add agents/
git add -u .claude/agents/
git commit -m "feat: migrate agents to plugin format with improved descriptions"
```

---

## Task 3: New Agents — Planner and Tester

**Files:**
- Create: `agents/planner.md`, `agents/tester.md`

- [ ] **Step 1: Create `agents/planner.md`**

```markdown
---
name: planner
description: Use when you need to break down a complex goal into steps, create roadmaps, or design an approach before implementation
tools: Read, Glob, Grep
model: sonnet
---

You are the **Planner**, a specialist focused on strategic planning and task decomposition.

## Your Expertise

- Breaking complex goals into actionable steps
- Roadmapping and milestone planning
- Identifying dependencies and risks
- Decision frameworks and trade-off analysis
- Architecture and approach design

## Planning Principles

✓ Start with the goal, work backwards to tasks
✓ Make dependencies explicit
✓ Flag risks and unknowns early
✓ Keep plans actionable and time-bound
✓ Prefer reversible decisions over irreversible ones

## Planning Process

1. **Understand the goal**: What does success look like?
2. **Identify constraints**: Time, resources, dependencies
3. **Decompose**: Break into independent subtasks
4. **Sequence**: Order by dependencies
5. **Risk analysis**: What could go wrong?
6. **Output**: Structured plan with milestones

## Output Format

1. **Goal**: One sentence definition of success
2. **Approach**: High-level strategy
3. **Tasks**: Numbered, sequenced, with owners/estimates if applicable
4. **Dependencies**: What blocks what
5. **Risks**: Top 3 risks and mitigations
6. **Next step**: The single most important thing to do first

Always be concrete — avoid vague steps like "research the problem."
```

- [ ] **Step 2: Create `agents/tester.md`**

```markdown
---
name: tester
description: Use when you need to write tests, design test strategies, evaluate coverage, or run end-to-end tests to validate code changes
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You are the **Tester**, a specialist focused on software quality and test coverage.

## Your Expertise

- Writing unit, integration, and end-to-end tests
- Test strategy and coverage analysis
- Identifying edge cases and failure modes
- Running and interpreting test output
- Validating code changes don't introduce regressions

## Testing Principles

✓ Test behavior, not implementation
✓ Each test has one clear assertion
✓ Tests should be deterministic and isolated
✓ Cover happy path, edge cases, and error cases
✓ Test names describe what they verify

## Testing Process

1. **Understand**: What does the code do? What could go wrong?
2. **Plan**: Happy path, edge cases, error cases
3. **Write**: One test per behavior
4. **Run**: Execute and interpret results
5. **Report**: Summarize coverage and findings

## Output Format

1. **Test strategy**: What types of tests and why
2. **Test code**: Complete, runnable test files
3. **Run instructions**: Exact commands to execute tests
4. **Results summary**: What passed, failed, and why
5. **Gaps**: What's not covered and whether it matters

Always run the tests after writing them and report actual output.
```

- [ ] **Step 3: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add agents/planner.md agents/tester.md
git commit -m "feat: add planner and tester agents"
```

---

## Task 4: Command — `/personal:agents`

**Files:**
- Create: `commands/agents.md`

- [ ] **Step 1: Create commands directory and file**

```bash
mkdir -p /Users/benben/Projects/personal-agents/commands
```

Create `commands/agents.md`:

```markdown
---
description: List all available personal agents with their purpose and example usage
---

List all available agents in the personal plugin. For each agent, show:
- Name
- What it's best used for (one sentence)
- Example invocation

Agents:

| Agent | Purpose | Example |
|---|---|---|
| **coder** | Write, edit, debug, or refactor code | "Use the coder agent to implement this feature" |
| **researcher** | Find information from web, codebase, or other sources | "Use the researcher agent to find best practices for X" |
| **fact-checker** | Verify claims and cross-reference sources | "Use the fact-checker agent to verify these claims" |
| **writer** | Produce polished docs, articles, tutorials, reports | "Use the writer agent to write a README for this project" |
| **planner** | Break down goals, create roadmaps, design approach | "Use the planner agent to create a task breakdown for this feature" |
| **tester** | Write tests, evaluate coverage, run end-to-end validation | "Use the tester agent to write tests for this module" |

After displaying this table, ask: "Which agent would you like to invoke, or would you like help choosing one for your task?"
```

- [ ] **Step 2: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add commands/agents.md
git commit -m "feat: add /personal:agents command"
```

---

## Task 5: Hook — SessionStart

**Files:**
- Create: `hooks/session-start.sh`
- Create: `hooks/hooks.json`

- [ ] **Step 1: Create hooks directory**

```bash
mkdir -p /Users/benben/Projects/personal-agents/hooks
```

- [ ] **Step 2: Create `hooks/session-start.sh`**

```bash
#!/bin/bash
# SessionStart hook — prints available personal agents as a reminder

echo ""
echo "Personal agents loaded: coder · researcher · fact-checker · writer · planner · tester"
echo "Run /personal:agents for details."
echo ""
```

- [ ] **Step 3: Make it executable**

```bash
chmod +x /Users/benben/Projects/personal-agents/hooks/session-start.sh
```

- [ ] **Step 4: Create `hooks/hooks.json`**

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh"
          }
        ]
      }
    ]
  }
}
```

- [ ] **Step 5: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add hooks/
git commit -m "feat: add SessionStart hook"
```

---

## Task 6: Cleanup — Remove Stale Files

**Files:**
- Delete: `scripts/`, `examples/`, `TMUX_SETUPS.md`, `.claude/settings.local.json`

- [ ] **Step 1: Remove stale files**

```bash
cd /Users/benben/Projects/personal-agents
rm -rf scripts/ examples/
rm -f TMUX_SETUPS.md
rm -f .claude/settings.local.json
```

- [ ] **Step 2: Remove .claude directory if now empty**

```bash
rmdir /Users/benben/Projects/personal-agents/.claude 2>/dev/null || true
```

- [ ] **Step 3: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add -u
git commit -m "chore: remove stale scripts, examples, and project-local settings"
```

---

## Task 7: Update README

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Rewrite `README.md`**

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd /Users/benben/Projects/personal-agents
git add README.md
git commit -m "docs: rewrite README for plugin setup"
```

---

## Task 8: Shell Alias Setup

- [ ] **Step 1: Verify the correct flag name**

```bash
claude --help | grep -i skip
```

Expected output will show either `--dangerously-skip-permissions` or similar. Use the exact flag shown.

- [ ] **Step 2: Add alias to `~/.zshrc`**

Open `~/.zshrc` and add (using the exact flag name from Step 1):

```zsh
alias claude='claude --plugin-dir ~/Projects/personal-agents --dangerously-skip-permissions'
```

- [ ] **Step 3: Reload shell**

```bash
source ~/.zshrc
```

- [ ] **Step 4: Verify alias is set**

```bash
alias claude
```

Expected: `claude='claude --plugin-dir ~/Projects/personal-agents --dangerously-skip-permissions'`

---

## Task 9: End-to-End Verification

- [ ] **Step 1: Validate plugin structure**

```bash
claude plugins validate /Users/benben/Projects/personal-agents
```

Expected: validation passes with no errors.

- [ ] **Step 2: Start a new session and check SessionStart output**

```bash
claude
```

Expected: Session opens and prints:
```
Personal agents loaded: coder · researcher · fact-checker · writer · planner · tester
Run /personal:agents for details.
```

- [ ] **Step 3: Test the command**

In the Claude session, run:
```
/personal:agents
```

Expected: Table of 6 agents is displayed, then Claude asks which to invoke.

- [ ] **Step 4: Test agent invocation**

In the Claude session, run:
```
Use the researcher agent to find what version of Python is installed
```

Expected: Claude spawns the researcher subagent which runs the task.

- [ ] **Step 5: Test resume works with plugin**

```bash
# Get session ID from a running session, then:
claude --resume <session-id>
```

Expected: Session resumes AND SessionStart hook fires, showing the agent reminder.
