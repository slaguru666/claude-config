#!/usr/bin/env bash
# Syncs live ~/.claude config into this repo, then commits and pushes.
# Usage: ./sync.sh [commit message]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
# Claude Code encodes the project dir by replacing the path separator with "-".
# macOS (/Users/x -> -Users-x) and Linux (/home/x -> -home-x) encode the POSIX $HOME.
# On Windows, Claude Code sees the native path, so C:\Users\x -> C--Users-x. Git Bash
# reports $HOME as /c/Users/x, which would encode to the wrong key -- convert first.
if command -v cygpath >/dev/null 2>&1; then
  # C:\Users\x -> C--Users-x (sed, not bash substitution: a lone "\" in a glob
  # pattern escapes the next char instead of matching a literal backslash).
  PROJECT_KEY="$(cygpath -w "$HOME" | sed 's/[\\:]/-/g')"
else
  PROJECT_KEY="${HOME//\//-}"
fi
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

if [ -d "$CLAUDE_DIR/skills" ]; then
  rsync -a --delete "$CLAUDE_DIR/skills/" "$SCRIPT_DIR/skills/"
  echo "  Copied: skills/"
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
