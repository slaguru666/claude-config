---
name: notebooklm-cli-setup
description: "NotebookLM CLI (teng-lin/notebooklm-py) installed on the Mac — install gotchas, auth, and the launchd keepalive"
metadata: 
  node_type: memory
  type: project
  originSessionId: f102e698-22a7-4706-8063-b599e2bd5fb1
---

Google NotebookLM wired into Claude Code on the **Mac Mini** via `teng-lin/notebooklm-py` (unofficial; no public NotebookLM API exists — Enterprise API is the only official path). Installed 2026-07-16.

- **Install:** `uv tool install --python 3.12 --force "notebooklm-py[browser]"` → binary at `~/.local/bin/notebooklm` (v0.7.3). **Gotcha:** plain `uv tool install` silently backtracks to the ancient 0.1.1 release (which tracebacks on import) because stock macOS Python is 3.9 and 0.7.3 needs ≥3.10. Always pin `--python 3.12`. `uv` itself came from Homebrew.
- **Skill:** `notebooklm skill install` → `~/.claude/skills/notebooklm/SKILL.md` (+ `~/.agents/skills/` for Codex). It's a skill, NOT an MCP server — won't show in `claude mcp list`, and the [[project_plugin_sync]] repo won't carry it to other machines. Each machine needs its own install + Google auth (creds are per-machine).
- **Auth:** `notebooklm login --browser chrome` (bundled Chromium crashes on macOS 15+/27; use system Chrome). Browser sign-in, auto-saves `~/.notebooklm/profiles/default/storage_state.json`. There is **no "master-token" auth** despite the repo blurb implying one.
- **Durability ("all the time"):** launchd keepalive at `~/Library/LaunchAgents/uk.timevans.notebooklm-refresh.plist` runs `notebooklm auth refresh --quiet` every 1200s, logs to `~/.notebooklm/refresh.log` (empty log = healthy; `--quiet` only writes on error). Loaded via `launchctl load`. Still an unofficial cookie session — a Google-side change or revocation needs a fresh `notebooklm login`; the log is where failure surfaces.
- **Verify:** `notebooklm auth check --test` (live token fetch) and `notebooklm list`. Free tier ~50 queries/day.
- **Claude Desktop sharing (2026-07-16):** a thin stdio MCP wrapper at `~/.notebooklm/mcp_server.py` (FastMCP, tools: `list_notebooks`, `ask_notebook`, `notebook_summary`) shells out to the same `notebooklm` binary, reusing the same auth + keepalive. Registered in `~/Library/Application Support/Claude/claude_desktop_config.json` under `mcpServers.notebooklm` as `/opt/homebrew/bin/uv run --python 3.12 --with mcp python ~/.notebooklm/mcp_server.py`. Requires a Desktop restart to load. The `mcp_server.py` and Desktop config are NOT in the [[project_plugin_sync]] repo (Mac-only, machine-specific paths). **claude.ai web is not viable** — sandboxed, no local access; would require hosting a remote MCP server with the Google cookies on it (declined for safety).
