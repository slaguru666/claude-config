#!/usr/bin/env bash
# Shared helpers for install.sh and sync.sh. Sourced, not executed.
#
# Claude Code stores per-project memory at ~/.claude/projects/<KEY>/memory, where
# <KEY> is the project's absolute path with the path separator replaced by "-".
# The home project ($HOME) syncs into memory/. Any *other* project dir holding
# memory worth keeping is listed below and syncs into memory/projects/<slug>/.
#
# Entries are relative to $HOME so the list stays portable: "projects/MacMem"
# resolves to -Users-timevans-projects-MacMem on macOS and
# -home-timevans-projects-MacMem on Linux.
EXTRA_PROJECT_PATHS=(
  "projects/MacMem"
  "Git"
)

# Encode an absolute path into the key Claude Code uses for its project dir.
# macOS (/Users/x -> -Users-x) and Linux (/home/x -> -home-x) encode the POSIX path.
# On Windows, Claude Code sees the native path, so C:\Users\x -> C--Users-x. Git Bash
# reports /c/Users/x, which would encode to the wrong key -- convert first.
project_key_for() {
  if command -v cygpath >/dev/null 2>&1; then
    # sed, not bash substitution: a lone "\" in a glob pattern escapes the next
    # char instead of matching a literal backslash.
    cygpath -w "$1" | sed 's/[\\:]/-/g'
  else
    echo "${1//\//-}"
  fi
}

# Repo-side folder name for an entry in EXTRA_PROJECT_PATHS.
project_slug_for() {
  echo "${1//\//-}"
}
