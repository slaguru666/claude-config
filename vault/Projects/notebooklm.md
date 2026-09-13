---
type: project
status: complete
repo: none — upstream teng-lin/notebooklm-py
path: ~/.claude/skills/notebooklm
updated: 2026-09-13
---

# NotebookLM

**What it is** — Google NotebookLM wired into Claude Code on the Mac via the
unofficial `notebooklm-py`. There is no public NotebookLM API; the Enterprise API is
the only official path. Installed 2026-07-16.

**Where it lives** — Binary `~/.local/bin/notebooklm` (v0.7.3). Skill at
`~/.claude/skills/notebooklm/SKILL.md`. Auth state in
`~/.notebooklm/profiles/default/storage_state.json`. A thin stdio MCP wrapper at
`~/.notebooklm/mcp_server.py` shares it with Claude Desktop.

**Current state** — Working, with a launchd keepalive at
`uk.timevans.notebooklm-refresh.plist` refreshing auth every 1200 s. An empty
`~/.notebooklm/refresh.log` means healthy — it only writes on error.

**Next steps** — none.

**Key decisions**
- It is a **skill, not an MCP server**, so it won't appear in `claude mcp list` and
  [[claude-config-sync]] will not carry it to other machines. Each machine needs its
  own install and its own Google auth.
- claude.ai web was ruled out — it is sandboxed, and making it work would mean
  hosting a remote MCP server with Google cookies on it. Declined for safety.

**Gotchas**
- **Always pin `--python 3.12`.** Plain `uv tool install` silently backtracks to the
  ancient 0.1.1 release, which tracebacks on import, because stock macOS Python is 3.9.
- `notebooklm login --browser chrome` — the bundled Chromium crashes on macOS 15+.
- There is no "master-token" auth despite the repo blurb implying one.
- Free tier is about 50 queries a day.

Related: [[claude-config-sync]], [[local-llm-stack]]
