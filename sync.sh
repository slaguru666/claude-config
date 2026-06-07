#!/usr/bin/env bash
# Syncs live ~/.claude config into this repo, then commits and pushes.
# Usage: ./sync.sh [commit message]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
# Claude Code encodes the project dir by replacing "/" with "-".
# Derive from $HOME so it works on macOS (/Users/x -> -Users-x) and Linux (/home/x -> -home-x).
PROJECT_KEY="${HOME//\//-}"
MEMORY_DIR="$CLAUDE_DIR/projects/${PROJECT_KEY}/memory"
MSG="${1:-sync config}"

echo "Syncing from ~/.claude ..."

cp "$CLAUDE_DIR/CLAUDE.md" "$SCRIPT_DIR/CLAUDE.md"
echo "  Copied: CLAUDE.md"

cp "$CLAUDE_DIR/settings.json" "$SCRIPT_DIR/settings.json"
echo "  Copied: settings.json"

if [ -d "$MEMORY_DIR" ] && ls "$MEMORY_DIR"/*.md &>/dev/null; then
  # Remove stale files, then copy fresh
  rm -f "$SCRIPT_DIR/memory/"*.md
  cp "$MEMORY_DIR/"*.md "$SCRIPT_DIR/memory/"
  echo "  Copied: memory/*.md"
else
  echo "  Warning: no memory files found at $MEMORY_DIR — skipping"
fi

cd "$SCRIPT_DIR"
git add -A
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  git commit -m "$MSG"
  git push
  echo ""
  echo "Pushed."
fi
