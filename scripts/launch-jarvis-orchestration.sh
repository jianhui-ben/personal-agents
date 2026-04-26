#!/bin/bash
# Launch Jarvis Orchestration: automated multi-agent tmux session
# Usage: ./launch-jarvis-orchestration.sh [session-name]

SESSION=${1:-jarvis_workflow}
PROJECT_DIR="/Users/benben/Projects/personal-agents"

# Check if session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session '$SESSION' already exists. Attaching..."
    tmux attach-session -t "$SESSION"
    exit 0
fi

# Create new session with first window: Orchestration
tmux new-session -d -s "$SESSION" -n orchestration -c "$PROJECT_DIR" -x 200 -y 50

# Pane 1.1 (left): Jarvis orchestrator
tmux send-keys -t "$SESSION:orchestration" "echo 'Jarvis Orchestrator pane. Running: @\"jarvis (agent)\" [workflow]'" Enter
tmux send-keys -t "$SESSION:orchestration" "clear" Enter

# Split vertically for Pane 1.2 (right): Logs/monitoring
tmux split-window -h -t "$SESSION:orchestration" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:orchestration.1" "tail -f ~/.claude/logs/*.log 2>/dev/null || echo 'Logs appear here when agents run'" Enter

# Create a second window for active agent work
tmux new-window -t "$SESSION" -n active-agent -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:active-agent" "echo 'Active agent output appears here. Monitor subagent work.'" Enter
tmux send-keys -t "$SESSION:active-agent" "clear" Enter

# Create a third window for workspace/editor
tmux new-window -t "$SESSION" -n workspace -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:workspace" "ls -la" Enter

# Select first window
tmux select-window -t "$SESSION:orchestration"

# Attach to the session
echo "Launching Jarvis Orchestration: '$SESSION'"
echo ""
echo "Windows:"
echo "  orchestration  - Jarvis + live logs"
echo "  active-agent   - Current subagent output"
echo "  workspace      - Files and workspace"
echo ""
echo "Navigate windows: Ctrl-b n (next) or p (previous)"
echo "Navigate panes: Ctrl-b h/j/k/l (vim-style)"
echo ""

tmux attach-session -t "$SESSION"
