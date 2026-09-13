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
ALLOW_DUP_HEADINGS=0
ARGS=()
for a in "$@"; do
  case "$a" in
    --allow-duplicate-headings) ALLOW_DUP_HEADINGS=1 ;;
    *) ARGS+=("$a") ;;
  esac
done
MSG="${ARGS[0]:-sync config}"

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
# Guard: a note whose heading appears twice is the signature of two writers
# colliding, or of an anchor-replace run without count=1 on an already-doubled
# file. Checked against CANONICAL, before the rsync, so a doubled note never
# reaches the repo copy. Failing it skips only the vault stage — CLAUDE.md,
# settings, memory and skills still sync — and the run exits non-zero at the end.
# Every grep here tolerates no-match; this script runs under `set -euo pipefail`.
VAULT_GUARD_FAILED=0
if [ -d "$VAULT_SRC" ]; then
  _dupes=""
  while IFS= read -r f; do
    d=$(grep -oE '^\*\*[A-Z][a-z ]+\*\*|^#{1,6} .*' "$f" 2>/dev/null | sort | uniq -d || true)
    [ -n "$d" ] && _dupes="${_dupes}      ${f#"$VAULT_SRC"/}\n$(echo "$d" | sed 's/^/          /')\n"
  done < <(find "$VAULT_SRC" -name '*.md' 2>/dev/null || true)

  if [ -n "$_dupes" ] && [ "$ALLOW_DUP_HEADINGS" != "1" ]; then
    echo ""
    echo "  REFUSING to sync the vault — duplicated headings:"
    printf "%b" "$_dupes"
    echo "  Two writers collided, or an anchor-replace ran without count=1."
    echo "  Fold the sections into one and re-run, or override with:"
    echo "      ./sync.sh --allow-duplicate-headings"
    echo ""
    VAULT_GUARD_FAILED=1
  fi

  # Notes present in the repo copy but not canonical are about to be deleted by
  # --delete. That means someone edited the repo copy instead of canonical.
  if [ -d "$SCRIPT_DIR/vault" ]; then
    _orphans=$(cd "$SCRIPT_DIR/vault" && find . -name '*.md' 2>/dev/null | while read -r r; do
      [ -f "$VAULT_SRC/${r#./}" ] || echo "      ${r#./}"
    done || true)
    if [ -n "$_orphans" ]; then
      echo ""
      echo "  WARNING — in claude-config/vault/ but NOT in canonical; about to be deleted:"
      echo "$_orphans"
      echo "  If that is an edit made in the repo copy, move it to $VAULT_SRC first."
      echo ""
    fi
  fi
fi

if [ -d "$VAULT_SRC" ] && [ "$VAULT_GUARD_FAILED" = "0" ]; then
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
elif [ "$VAULT_GUARD_FAILED" = "1" ]; then
  echo "  Skipped: vault/ — guard refused (see above); repo copy left intact"
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

if [ "$VAULT_GUARD_FAILED" = "1" ]; then
  echo ""
  echo "  NOTE: everything except the vault was synced. The vault was held back"
  echo "  because of the duplicated headings listed above. Fix them and re-run."
  exit 1
fi
