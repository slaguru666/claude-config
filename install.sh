#!/usr/bin/env bash
# Installs Claude config files to ~/.claude/
# Usage: ./install.sh
# Run this on any machine after cloning the repo.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
USERNAME=$(whoami)
# shellcheck source=project-paths.sh
source "$SCRIPT_DIR/project-paths.sh"
PROJECT_KEY="$(project_key_for "$HOME")"
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

# Extra per-project memory dirs (see project-paths.sh)
for rel in "${EXTRA_PROJECT_PATHS[@]}"; do
  src="$SCRIPT_DIR/memory/projects/$(project_slug_for "$rel")"
  if [ -d "$src" ] && ls "$src"/*.md &>/dev/null; then
    dest="$CLAUDE_DIR/projects/$(project_key_for "$HOME/$rel")/memory"
    mkdir -p "$dest"
    cp "$src/"*.md "$dest/"
    echo "  Installed: memory ($rel) -> $dest"
  fi
done

# Obsidian memory vault -> the slavault vault, when this machine has one.
# Overlay only, no --delete: a machine's own newer notes are never destroyed by an
# install. Machines with no Obsidian vault (MINI-S) read the repo copy directly.
if [ -d "$SCRIPT_DIR/vault" ]; then
  if [ -d "$HOME/Vault/slavault" ]; then
    VAULT_DEST="$HOME/Vault/slavault/Ai/Claude"
    mkdir -p "$VAULT_DEST"
    if command -v rsync >/dev/null 2>&1; then
      rsync -a "$SCRIPT_DIR/vault/" "$VAULT_DEST/"
    else
      cp -R "$SCRIPT_DIR/vault/." "$VAULT_DEST/"
    fi
    echo "  Installed: memory vault -> $VAULT_DEST"
  else
    echo "  Memory vault available at $SCRIPT_DIR/vault (no Obsidian vault on this machine)"
  fi
fi

# Skills — copy each skill directory into ~/.claude/skills/
if [ -d "$SCRIPT_DIR/skills" ]; then
  mkdir -p "$CLAUDE_DIR/skills"
  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$SCRIPT_DIR/skills/" "$CLAUDE_DIR/skills/"
  else
    # No rsync (Git Bash on Windows). This direction is a plain overlay with no
    # --delete, so cp is an exact substitute.
    cp -R "$SCRIPT_DIR/skills/." "$CLAUDE_DIR/skills/"
  fi
  echo "  Installed: skills -> ~/.claude/skills/"
fi

# CLI dependencies — Codex CLI, required by the codex@openai-codex plugin to actually run.
if command -v codex >/dev/null 2>&1; then
  echo "  Codex CLI already present: $(codex --version 2>/dev/null | head -1)"
elif command -v npm >/dev/null 2>&1; then
  echo "  Installing Codex CLI (npm install -g @openai/codex)..."
  npm install -g @openai/codex >/dev/null 2>&1 \
    && echo "  Installed: Codex CLI $(codex --version 2>/dev/null | head -1)" \
    || echo "  WARNING: Codex CLI install failed — run manually: npm install -g @openai/codex"
else
  echo "  WARNING: npm not found — install the Codex CLI manually: npm install -g @openai/codex"
fi

# QuickDesign CLI, required by the quickdesign@claude-community plugin to actually run.
# The bundled skill only wraps this binary; without it every invocation dies on "command not found".
# Auth is per-machine and NOT synced — run `quickdesign login` once per box. Do not run
# `quickdesign init`: it copies the skill into ~/.claude/skills/, duplicating the plugin's copy.
if command -v quickdesign >/dev/null 2>&1; then
  echo "  QuickDesign CLI already present: $(quickdesign --version 2>/dev/null | head -1)"
elif command -v npm >/dev/null 2>&1; then
  echo "  Installing QuickDesign CLI (npm install -g @quickdesign/cli)..."
  npm install -g @quickdesign/cli >/dev/null 2>&1 \
    && echo "  Installed: QuickDesign CLI $(quickdesign --version 2>/dev/null | head -1)" \
    || echo "  WARNING: QuickDesign CLI install failed — run manually: npm install -g @quickdesign/cli"
else
  echo "  WARNING: npm not found — install the QuickDesign CLI manually: npm install -g @quickdesign/cli"
fi

# Obsidian vault MCP server (filesystem access).
# The vault lives in a different place on every machine: on MINI-S it is inside the
# homelab Docker stack (~/docker/obsidian/config/...), on the Macs it is a native
# Obsidian vault under ~/Vault. The old hardcoded /home/timevans/... path could never
# match on macOS, so this step silently skipped there on every install.
# Candidates are probed in order and every one that exists is granted to the server.
# Override with OBSIDIAN_VAULT_PATHS (colon-separated) before running.
if command -v claude >/dev/null 2>&1; then
  if [ -n "${OBSIDIAN_VAULT_PATHS:-}" ]; then
    IFS=':' read -r -a CANDIDATE_VAULTS <<< "$OBSIDIAN_VAULT_PATHS"
  else
    CANDIDATE_VAULTS=(
      "$HOME/docker/obsidian/config/Obsidian Vault"
      "$HOME/Vault/Tims_Vault"
      "$HOME/Vault/slavault"
    )
  fi

  FOUND_VAULTS=()
  for candidate in "${CANDIDATE_VAULTS[@]}"; do
    [ -d "$candidate" ] && FOUND_VAULTS+=("$candidate")
  done

  if [ "${#FOUND_VAULTS[@]}" -gt 0 ]; then
    echo "  Setting up Obsidian MCP server (${#FOUND_VAULTS[@]} vault(s))..."
    claude mcp remove obsidian -s user 2>/dev/null || true
    claude mcp add obsidian -s user -- npx -y @modelcontextprotocol/server-filesystem "${FOUND_VAULTS[@]}" \
      && for v in "${FOUND_VAULTS[@]}"; do echo "  Installed: Obsidian MCP server -> $v"; done \
      || echo "  WARNING: Obsidian MCP server setup failed"
  else
    echo "  Skipping Obsidian MCP server — no vault found in: ${CANDIDATE_VAULTS[*]}"
  fi
fi

# GitHub MCP server (official remote server at api.githubcopilot.com).
# The old @modelcontextprotocol/server-github stdio package is deprecated ("Package no longer
# supported", last published 2025.4.8) and is no longer used.
#
# Claude Code's built-in OAuth flow does NOT work here: GitHub's authorization server
# publishes no registration_endpoint (confirmed at
# https://github.com/.well-known/oauth-authorization-server/login/oauth), so /mcp fails with
# "Incompatible auth server: does not support dynamic client registration". Two routes work
# instead; the OAuth app takes precedence when configured.
#
#   1. Pre-registered OAuth app — export GITHUB_MCP_CLIENT_ID and MCP_CLIENT_SECRET.
#      Optionally GITHUB_MCP_CALLBACK_PORT if the app pins a redirect URI.
#   2. PAT — export GITHUB_MCP_TOKEN (or the older GITHUB_PERSONAL_ACCESS_TOKEN).
#      Stored in plaintext in ~/.claude.json, so rotate it as you would any credential.
#
# Override the endpoint by exporting GITHUB_MCP_URL before running.
if command -v claude >/dev/null 2>&1; then
  GITHUB_MCP_URL="${GITHUB_MCP_URL:-https://api.githubcopilot.com/mcp/}"
  GITHUB_MCP_TOKEN="${GITHUB_MCP_TOKEN:-${GITHUB_PERSONAL_ACCESS_TOKEN:-}}"

  if [ -n "${GITHUB_MCP_CLIENT_ID:-}" ] && [ -n "${MCP_CLIENT_SECRET:-}" ]; then
    echo "  Setting up GitHub MCP server (OAuth app, $GITHUB_MCP_URL)..."
    GH_ARGS=(github "$GITHUB_MCP_URL" --transport http -s user
             --client-id "$GITHUB_MCP_CLIENT_ID" --client-secret)
    if [ -n "${GITHUB_MCP_CALLBACK_PORT:-}" ]; then
      GH_ARGS+=(--callback-port "$GITHUB_MCP_CALLBACK_PORT")
    fi
    claude mcp remove github -s user 2>/dev/null || true
    claude mcp add "${GH_ARGS[@]}" \
      && echo "  Installed: GitHub MCP server (OAuth app) — run /mcp to complete authorisation" \
      || echo "  WARNING: GitHub MCP server setup failed (OAuth app route)"
  elif [ -n "${GITHUB_MCP_CLIENT_ID:-}" ]; then
    echo "  Skipping GitHub MCP server — GITHUB_MCP_CLIENT_ID is set but MCP_CLIENT_SECRET is not."
    echo "    (--client-secret would block waiting for a prompt, so both are required together.)"
  elif [ -n "$GITHUB_MCP_TOKEN" ]; then
    echo "  Setting up GitHub MCP server (PAT header, $GITHUB_MCP_URL)..."
    claude mcp remove github -s user 2>/dev/null || true
    claude mcp add github "$GITHUB_MCP_URL" --transport http -s user \
      --header "Authorization: Bearer $GITHUB_MCP_TOKEN" \
      && echo "  Installed: GitHub MCP server (PAT)" \
      || echo "  WARNING: GitHub MCP server setup failed (PAT route)"
  else
    echo "  Skipping GitHub MCP server — export GITHUB_MCP_TOKEN (PAT),"
    echo "    or GITHUB_MCP_CLIENT_ID + MCP_CLIENT_SECRET (OAuth app), then re-run."
  fi
fi

# Graphiti MCP server (knowledge-graph memory, HTTP transport)
# Override the endpoint by exporting GRAPHITI_MCP_URL before running.
if command -v claude >/dev/null 2>&1; then
  GRAPHITI_MCP_URL="${GRAPHITI_MCP_URL:-https://graphiti.timevans.uk/mcp}"
  echo "  Setting up Graphiti MCP server ($GRAPHITI_MCP_URL)..."
  claude mcp remove graphiti-memory -s user 2>/dev/null || true
  claude mcp add graphiti-memory "$GRAPHITI_MCP_URL" --transport http -s user \
    && echo "  Installed: Graphiti MCP server" \
    || echo "  WARNING: Graphiti MCP server setup failed — run manually: claude mcp add graphiti-memory $GRAPHITI_MCP_URL --transport http -s user"
fi

echo ""
echo "Done. Restart Claude Code for settings to take effect."
