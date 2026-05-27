#!/bin/bash
# Install all plugin dependencies declared in .claude-plugin/plugin.json
# Usage: ./scripts/install-deps.sh

set -e

MARKETPLACE="claude-plugins-official"
DEPS=(superpowers skill-creator github)

echo "Installing personal-plugin dependencies..."
for dep in "${DEPS[@]}"; do
  echo "  → $dep"
  claude plugins install "$dep@$MARKETPLACE" 2>/dev/null && echo "    ✓ installed" || echo "    ✓ already installed"
done

echo ""
echo "Done. Run /reload-plugins in Claude Code to activate."
