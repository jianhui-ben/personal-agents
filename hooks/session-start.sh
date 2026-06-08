#!/bin/bash
# SessionStart hook — prints available personal agents and weekly lint reminder

echo ""
echo "Personal agents loaded: coder · researcher · fact-checker · writer · planner · tester · wiki"
echo "Run /personal:agents for details."
echo ""

# Weekly wiki lint reminder — fires on Mondays
if [ "$(date +%u)" = "1" ]; then
  echo "Weekly wiki lint due — run /personal:wiki-lint to keep your wiki healthy."
  echo ""
fi
