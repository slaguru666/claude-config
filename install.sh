#!/usr/bin/env bash
# Installs Claude config files to ~/.claude/
# Usage: ./install.sh
# Run this on any machine after cloning the repo.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
USERNAME=$(whoami)
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

# Skills — copy each skill directory into ~/.claude/skills/
if [ -d "$SCRIPT_DIR/skills" ]; then
  mkdir -p "$CLAUDE_DIR/skills"
  rsync -a "$SCRIPT_DIR/skills/" "$CLAUDE_DIR/skills/"
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

# Obsidian vault MCP server (filesystem access)
if command -v claude >/dev/null 2>&1; then
  VAULT_PATH="/home/timevans/docker/obsidian/config/Obsidian Vault"
  if [ -d "$VAULT_PATH" ]; then
    echo "  Setting up Obsidian MCP server..."
    claude mcp remove obsidian -s user 2>/dev/null || true
    claude mcp add obsidian -s user -- npx -y @modelcontextprotocol/server-filesystem "$VAULT_PATH" \
      && echo "  Installed: Obsidian MCP server" \
      || echo "  WARNING: Obsidian MCP server setup failed"
  else
    echo "  Skipping Obsidian MCP server — vault not found at $VAULT_PATH"
  fi
fi

# GitHub MCP server (PAT-based, stdio)
if command -v claude >/dev/null 2>&1; then
  if [ -n "${GITHUB_PERSONAL_ACCESS_TOKEN:-}" ]; then
    echo "  Setting up GitHub MCP server..."
    claude mcp remove github -s user 2>/dev/null || true
    claude mcp add github -s user \
      -e GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN" \
      -- npx -y @modelcontextprotocol/server-github \
      && echo "  Installed: GitHub MCP server" \
      || echo "  WARNING: GitHub MCP server setup failed — run manually: claude mcp add github -s user -e GITHUB_PERSONAL_ACCESS_TOKEN=<token> -- npx -y @modelcontextprotocol/server-github"
  else
    echo "  Skipping GitHub MCP server — set GITHUB_PERSONAL_ACCESS_TOKEN before running to enable"
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
