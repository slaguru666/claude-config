#!/usr/bin/env bash
# Installs Claude config files to ~/.claude/
# Usage: ./install.sh
# Run this on any machine after cloning the repo.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
USERNAME=$(whoami)
# Claude Code encodes the project dir by replacing "/" with "-".
# Derive from $HOME so it works on macOS (/Users/x -> -Users-x) and Linux (/home/x -> -home-x).
PROJECT_KEY="${HOME//\//-}"
MEMORY_DIR="$CLAUDE_DIR/projects/${PROJECT_KEY}/memory"

echo "Installing Claude config for user: $USERNAME"

# CLAUDE.md
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  Installed: ~/.claude/CLAUDE.md"

# settings.json — back up if it already exists
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  echo "  Backed up: ~/.claude/settings.json -> settings.json.bak"
fi
cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "  Installed: ~/.claude/settings.json"

# Memory files — copy all .md files from memory/
mkdir -p "$MEMORY_DIR"
cp "$SCRIPT_DIR/memory/"*.md "$MEMORY_DIR/"
echo "  Installed: memory files -> $MEMORY_DIR"

echo ""
echo "Done. Restart Claude Code for settings to take effect."
