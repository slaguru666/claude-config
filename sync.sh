#!/usr/bin/env bash
# Syncs live ~/.claude config into this repo, then commits and pushes.
# Usage: ./sync.sh [commit message]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
# shellcheck source=project-paths.sh
source "$SCRIPT_DIR/project-paths.sh"
PROJECT_KEY="$(project_key_for "$HOME")"
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

# Extra per-project memory dirs (see project-paths.sh). A machine that lacks one
# of these projects skips it, leaving the repo copy intact — never deletes it.
for rel in "${EXTRA_PROJECT_PATHS[@]}"; do
  src="$CLAUDE_DIR/projects/$(project_key_for "$HOME/$rel")/memory"
  slug="$(project_slug_for "$rel")"
  if [ -d "$src" ] && ls "$src"/*.md &>/dev/null; then
    mkdir -p "$SCRIPT_DIR/memory/projects/$slug"
    rm -f "$SCRIPT_DIR/memory/projects/$slug/"*.md
    cp "$src/"*.md "$SCRIPT_DIR/memory/projects/$slug/"
    echo "  Copied: memory/projects/$slug/"
  else
    echo "  Skipped: memory/projects/$slug/ — not present on this machine"
  fi
done

if [ -d "$CLAUDE_DIR/skills" ]; then
  # --no-links: skills installed by other tools (firecrawl, composio) are symlinks
  # into ~/.agents/skills. Copying them as symlinks would commit links that dangle
  # on every other machine; dereferencing them would vendor someone else's skills.
  # Only real skill directories belong in this repo.
  rsync -a --delete --no-links "$CLAUDE_DIR/skills/" "$SCRIPT_DIR/skills/"
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
