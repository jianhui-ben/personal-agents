# Personal Agents Project

Multi-agent system for personal development tasks using Claude Code's native subagent system.

## Architecture

- **jarvis**: Orchestrates workflows (main entry point)
- **planner**: Strategic planning and brainstorming
- **researcher**: Information gathering and analysis
- **coder**: Code implementation and debugging
- **fact-checker**: Verification and validation
- **writer**: Content creation and documentation

## Usage

Run Claude Code from this directory. Jarvis will automatically coordinate specialists based on your request.

## Examples

```bash
# Let Jarvis coordinate agents
claude "plan a feature, research it, implement, and document"

# Invoke specific agents directly
claude "have the planner create a product roadmap"
claude "have the coder write a REST API"

# Complex workflows
claude "research FastAPI, write example code, verify best practices, and create docs"
```

## How It Works

Each agent is a specialized subagent defined in `.claude/agents/`:
- Agents have specific tools they can use
- Jarvis uses the Task tool to delegate work
- Agents work together to complete complex workflows
- Context passes between agents automatically

## Future Extensions

- Add MCP (Model Context Protocol) servers for enhanced capabilities
- Add more specialized agents as needed
- Configure custom tools per agent
