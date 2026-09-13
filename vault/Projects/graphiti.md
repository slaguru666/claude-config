---
type: project
status: active
repo: none
path: graphiti.timevans.uk
updated: 2026-09-13
---

# Graphiti

**What it is** — A knowledge-graph memory service for AI agents, hosted at
`graphiti.timevans.uk`. Claude queries it at session start and writes decisions,
discoveries and project state back to it during a session.

**Where it lives** — `graphiti.timevans.uk`, reached through the `graphiti` MCP
server. Tools: `search_memory_facts`, `search_nodes`, `add_memory`, `get_episodes`.

**Current state** — In use. Facts carry temporal metadata, so a superseded fact is
marked invalid rather than deleted.

**Next steps** — none.

**Key decisions**
- 2026-09-13 — Graphiti stays the **fast searchable recall layer**; this vault is the
  **canonical human-readable one**. If they ever disagree, the vault wins. See [[DESIGN]].
- Scenario-specific facts go here rather than into the [[rpg-skill]] reference files.

**Gotchas**
- If a `search_memory_facts` call fails (for example an API key error), say so rather
  than quietly working without memory.

Related: [[rpg-skill]], [[claude-config-sync]]
