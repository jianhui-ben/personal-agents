#!/bin/bash
# Launch Command Center: human-orchestrated multi-agent tmux session
# Usage: ./launch-command-center.sh [session-name]

SESSION=${1:-command_center}
PROJECT_DIR="/Users/benben/Projects/personal-agents"

# Check if session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session '$SESSION' already exists. Attaching..."
    tmux attach-session -t "$SESSION"
    exit 0
fi

# Create new session
tmux new-session -d -s "$SESSION" -c "$PROJECT_DIR" -x 200 -y 50
sleep 0.5

# Create all panes first
# Pane 0.0: top-left (Researcher)
# Split horizontally to create 0.0 (left) and 0.1 (right)
tmux split-window -h -t "$SESSION:0" -c "$PROJECT_DIR"
sleep 0.3

# Split 0.0 vertically to create 0.0 (top-left) and 0.2 (bottom-left)
tmux split-window -v -t "$SESSION:0.0" -c "$PROJECT_DIR"
sleep 0.3

# Split 0.1 vertically to create 0.1 (top-right) and 0.3 (bottom-right)
tmux split-window -v -t "$SESSION:0.1" -c "$PROJECT_DIR"
sleep 0.5

# Now all panes exist: 0.0 (top-left), 0.1 (top-right), 0.2 (bottom-left), 0.3 (bottom-right)
# Send claude to each pane with explicit indices

# Pane 0.0: Researcher (top-left)
tmux send-keys -t "$SESSION:0.0" "cd $PROJECT_DIR && claude" Enter
sleep 0.5

# Pane 0.1: Coder (top-right)
tmux send-keys -t "$SESSION:0.1" "cd $PROJECT_DIR && claude" Enter
sleep 0.5

# Pane 0.2: Planner (bottom-left)
tmux send-keys -t "$SESSION:0.2" "cd $PROJECT_DIR && claude" Enter
sleep 0.5

# Pane 0.3: Writer (bottom-right)
tmux send-keys -t "$SESSION:0.3" "cd $PROJECT_DIR && claude" Enter
sleep 0.5

# Set pane layouts
tmux select-layout -t "$SESSION:0" tiled

# Attach to the session
echo "Launching Command Center: '$SESSION'"
echo ""
echo "Layout:"
echo "  [0.0: Researcher]  [0.1: Coder]"
echo "  [0.2: Planner]     [0.3: Writer]"
echo ""
echo "Each pane is running Claude in this project directory."
echo "In each pane, invoke an agent:"
echo "  @\"researcher (agent)\" [task]"
echo "  @\"coder (agent)\" [task]"
echo "  @\"planner (agent)\" [task]"
echo "  @\"writer (agent)\" [task]"
echo ""
echo "Navigate panes: Ctrl-b h/j/k/l (vim-style)"
echo "Detach session: Ctrl-b d (can reattach later)"
echo "Reload config: Ctrl-b r"
echo ""

sleep 2
tmux attach-session -t "$SESSION"
