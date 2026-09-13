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

# Obsidian memory vault. Canonical copy is the slavault vault on the Macs; the
# iCloud vault gets a one-way MIRROR so TASKS.md stays readable on the phone —
# edits made on the phone are overwritten, so treat the iCloud copy as read-only.
# A machine without slavault (MINI-S) skips this entirely, leaving the repo copy
# intact — the same never-delete-what-you-don't-have rule as the memory dirs above.
VAULT_SRC="$HOME/Vault/slavault/Ai/Claude"
VAULT_MIRROR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Ai/Claude"
if [ -d "$VAULT_SRC" ]; then
  if command -v rsync >/dev/null 2>&1; then
    mkdir -p "$SCRIPT_DIR/vault"
    rsync -a --delete --no-links "$VAULT_SRC/" "$SCRIPT_DIR/vault/"
    echo "  Copied: vault/"
    if [ -d "$(dirname "$VAULT_MIRROR")" ]; then
      rsync -a --delete "$VAULT_SRC/" "$VAULT_MIRROR/"
      echo "  Mirrored: vault -> iCloud vault"
    fi
  else
    echo "  Skipped: vault/ — rsync not found on this machine (repo copy left intact)"
  fi
else
  echo "  Skipped: vault/ — no ~/Vault/slavault/Ai/Claude on this machine"
fi

if [ -d "$CLAUDE_DIR/skills" ]; then
  # --no-links: skills installed by other tools (firecrawl, composio) are symlinks
  # into ~/.agents/skills. Copying them as symlinks would commit links that dangle
  # on every other machine; dereferencing them would vendor someone else's skills.
  # Only real skill directories belong in this repo.
  if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete --no-links "$CLAUDE_DIR/skills/" "$SCRIPT_DIR/skills/"
    echo "  Copied: skills/"
  else
    # No rsync (e.g. Git Bash on Windows). Skipping is the safe failure: a plain cp
    # cannot express --delete or --no-links, and getting it wrong has wiped skills/rpg
    # from the repo before. Sync skills from a machine that has rsync.
    echo "  Skipped: skills/ — rsync not found on this machine (repo copy left intact)"
  fi
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
