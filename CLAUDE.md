# Personal Agents Project

Multi-agent system for personal development tasks using Claude Code's native subagent system.

## Architecture

Claude Code itself acts as the orchestrator. Specialist subagents in `.claude/agents/` are delegated to as needed:

- **researcher**: Information gathering, web search, data analysis, source verification
- **coder**: Code implementation, debugging, and refactoring
- **fact-checker**: Verification and validation
- **writer**: Content creation and documentation

For planning, use Claude Code's built-in `/plan` mode.

## Usage

Run Claude Code from this directory and describe what you need. Claude will coordinate specialists automatically, or you can invoke them directly.

## Examples

```bash
# Claude coordinates specialists automatically
claude "research FastAPI, write example code, verify best practices, and create docs"

# Invoke specific agents directly
claude "have the researcher look into X"
claude "have the coder write a REST API"
```

## Future Extensions

- Add MCP (Model Context Protocol) servers for enhanced capabilities
- Add more specialized agents as needed
- Configure custom tools per agent
