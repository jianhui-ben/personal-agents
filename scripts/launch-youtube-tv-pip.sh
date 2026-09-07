#!/bin/bash
# Launch Chrome with the YouTube TV PiP extension loaded.
# Usage: ./scripts/launch-youtube-tv-pip.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSION_PATH="$SCRIPT_DIR/youtube-tv-pip"
YTTV_URL="https://tv.youtube.com"

echo "[YouTube TV PiP] Loading extension from: $EXTENSION_PATH"
echo "[YouTube TV PiP] Opening YouTube TV..."

# Launch Chrome directly (bypasses macOS 'open -a' merging into existing instance)
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --load-extension="$EXTENSION_PATH" \
  --user-data-dir="/tmp/youtube-tv-pip-profile" \
  "$YTTV_URL" &>/dev/null &

echo "[YouTube TV PiP] Chrome launched. Sign in and start the game."
echo "[YouTube TV PiP] It auto-enters PiP on play; click the toolbar icon to toggle."
