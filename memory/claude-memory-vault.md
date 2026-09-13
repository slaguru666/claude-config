---
name: claude-memory-vault
description: The canonical human-readable memory lives in the iCloud Obsidian vault at Ai/Claude/ — read INDEX.md at session start, write project state, tasks and decisions there automatically.
metadata:
  type: project
---

Built 2026-09-13. A durable Markdown record of all Claude work lives in the
**iCloud** Obsidian vault:
`~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Ai/Claude/`

`INDEX.md` (hub) · `TASKS.md` (one checkbox list) · `CONVENTIONS.md` (Tim's
corrections) · `Projects/<name>.md` (27 notes, one screen each) · `Log/YYYY-MM.md`
(append-only, dated decisions) · `DESIGN.md` (how it works).

It holds the **map, never the work** — paths, repos, ports, state, next steps,
decisions, gotchas. No code over five lines, no scenario text, no secrets. It is the
canonical layer; Graphiti and claude-mem are the fast recall layers, and if they
disagree the vault wins.

The full read/write protocol is in `~/.claude/CLAUDE.md` under "Claude Memory Vault
(Obsidian)" — follow it from there rather than re-deriving it.

Chosen over `~/Vault/slavault` (identical contents but local-only, no sync) precisely
because the point is surviving the loss of a machine. `~/Documents/TimsVault` and
`~/Documents/slavault` are stale and not registered in the Obsidian app.

Open: MINI-S is Linux with no iCloud and cannot see this vault — a Gitea mirror of
`Ai/Claude/` is the recommended fix, and would give it version history too.

Related: [[project_plugin_sync]], [[infra_minis_remote_access]].
