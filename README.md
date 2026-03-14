# Personal Agents

A multi-agent system for personal development using Claude Code's native subagent system.

## Quick Start

1. Clone or open this repository
2. Open with Claude Code
3. Agents are automatically available

## Usage

### Let Jarvis Coordinate Agents

```bash
claude "research quantum computing and explain for beginners"
```

Jarvis will automatically select appropriate agents (researcher → writer) to complete the task.

### Invoke Specific Agents

```bash
# Planning and brainstorming
claude "have the planner create a 3-month roadmap"

# Code implementation
claude "have the coder write a REST API using FastAPI"

# Research and analysis
claude "have the researcher find the latest developments in AI"

# Content creation
claude "have the writer create a tutorial on React hooks"

# Verification
claude "have the fact-checker verify these claims about climate change"
```

### Complex Multi-Step Workflows

```bash
# Full implementation workflow
claude "plan the architecture, research best practices, implement a REST API, verify it follows standards, and write documentation"

# Content pipeline
claude "research AI agent patterns, verify the claims, and write an article about multi-agent systems"
```

## Agents

### Jarvis (Orchestrator)
Coordinates all other agents. Use when you need multiple specialists to work together.

**Key capabilities:**
- Task decomposition
- Agent delegation
- Result synthesis

### Planner
Handles strategic planning, brainstorming, and decision frameworks.

**Key capabilities:**
- Roadmapping and milestone planning
- Brainstorming sessions
- Decision frameworks
- Risk analysis

### Researcher
Gathers and analyzes information from the web and documents.

**Key capabilities:**
- Web search and retrieval
- Data analysis
- Source verification
- Citation management

### Coder
Implements code solutions following best practices.

**Key capabilities:**
- Code generation
- Debugging
- Code review
- Testing

### Fact-Checker
Verifies claims and validates information accuracy.

**Key capabilities:**
- Claim verification
- Source credibility assessment
- Cross-reference checking

### Writer
Creates polished written content and documentation.

**Key capabilities:**
- Technical documentation
- Blog posts and articles
- Tutorials
- Report writing

## Workflow Examples

### Example 1: Research + Tutorial
```
Request: "Research React Server Components and create a beginner tutorial"

Jarvis Flow:
1. Delegates to Researcher: "Research React Server Components"
   → Returns: findings, sources, key concepts
2. Delegates to Writer: "Create tutorial using these findings"
   → Returns: complete tutorial with code examples
3. Aggregates results and delivers final tutorial
```

### Example 2: Full Implementation Cycle
```
Request: "Plan a new feature, research approaches, implement it, verify quality, and document"

Jarvis Flow:
1. Delegates to Planner: "Create implementation plan"
   → Returns: goals, approach, milestones
2. Delegates to Researcher: "Research best practices"
   → Returns: industry standards, examples
3. Delegates to Coder: "Implement using the plan and research"
   → Returns: working code, tests
4. Delegates to Fact-Checker: "Verify code quality and standards"
   → Returns: verification report
5. Delegates to Writer: "Create documentation"
   → Returns: complete documentation
6. Aggregates and delivers final package
```

### Example 3: Brainstorming + Planning
```
Request: "Brainstorm ideas for a mobile app and create implementation roadmap"

Jarvis Flow:
1. Delegates to Planner: "Brainstorm innovative features for mobile app"
   → Returns: idea list, evaluation, top recommendations
2. Delegates to Planner again: "Create 6-month implementation roadmap"
   → Returns: detailed roadmap with milestones
3. Aggregates results and delivers comprehensive plan
```

## Project Structure

```
.claude/agents/
├── jarvis.md           # Orchestrator
├── planner.md          # Planning specialist
├── researcher.md       # Research specialist
├── coder.md            # Coding specialist
├── fact-checker.md     # Verification specialist
└── writer.md           # Writing specialist

examples/
└── sample_workflows.md # Example prompts

CLAUDE.md              # Project conventions
README.md              # This file
.gitignore             # Git configuration
```

## Tips for Best Results

1. **Be specific**: Provide clear context and requirements
2. **Chain tasks**: Combine agents for complex workflows
3. **Review quality**: Each agent follows best practices
4. **Iterate**: Ask agents to refine or expand results
5. **Mix and match**: Use different agent combinations for different tasks

## Future Enhancements

- Add MCP (Model Context Protocol) servers for additional capabilities
- Add new specialized agents
- Configure custom tools
- Add persistence and history tracking

## Getting Help

For questions about Claude Code and subagents, refer to:
- Claude Code documentation
- Individual agent descriptions in `.claude/agents/`
