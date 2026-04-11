#!/usr/bin/env bash
# Installs Claude config files to ~/.claude/
# Usage: ./install.sh
# Run this on any machine after cloning the repo.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
USERNAME=$(whoami)
MEMORY_DIR="$CLAUDE_DIR/projects/-Users-${USERNAME}-Git/memory"

echo "Installing Claude config for user: $USERNAME"

# CLAUDE.md
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  Installed: ~/.claude/CLAUDE.md"

# settings.json — merge if file already exists, otherwise copy
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "  ~/.claude/settings.json already exists — backing up to settings.json.bak"
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
fi
cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "  Installed: ~/.claude/settings.json"

# Memory files
mkdir -p "$MEMORY_DIR"
cp "$SCRIPT_DIR/memory/MEMORY.md" "$MEMORY_DIR/MEMORY.md"
cp "$SCRIPT_DIR/memory/gsd-patterns.md" "$MEMORY_DIR/gsd-patterns.md"
cp "$SCRIPT_DIR/memory/superpowers-patterns.md" "$MEMORY_DIR/superpowers-patterns.md"
echo "  Installed: memory files -> $MEMORY_DIR"

echo ""
echo "Done. Restart Claude Code for settings to take effect."
