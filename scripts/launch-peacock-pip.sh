#!/bin/bash
# Launch Chrome with Peacock PiP extension loaded
# Usage: ./scripts/launch-peacock-pip.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSION_PATH="$SCRIPT_DIR/peacock-pip"
PEACOCK_URL="https://www.peacocktv.com"

echo "[Peacock PiP] Loading extension from: $EXTENSION_PATH"
echo "[Peacock PiP] Opening Peacock..."

# Launch Chrome directly (bypasses macOS open -a merging into existing instance)
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --load-extension="$EXTENSION_PATH" \
  --user-data-dir="/tmp/peacock-pip-profile" \
  "$PEACOCK_URL" &>/dev/null &

echo "[Peacock PiP] Chrome launched. Sign in to Peacock and start playing."
echo "[Peacock PiP] The video will auto-enter PiP mode when it starts playing."
