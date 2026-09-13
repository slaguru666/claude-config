---
name: claude-memory-vault
description: "The canonical human-readable memory is ~/Vault/slavault/Ai/Claude/ — read INDEX.md at session start and write state, tasks and decisions there; iCloud is a one-way mirror, never write to it."
metadata:
  type: project
---

Built 2026-09-13. A durable Markdown record of all Claude work.

**Write to `~/Vault/slavault/Ai/Claude/`** — that is canonical on the Macs. The
iCloud vault at
`~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Ai/Claude/` is
a **one-way mirror**, so TASKS.md is readable on the phone; `sync.sh` overwrites
it with `--delete` and writing there loses the work. An earlier version of this
memory named iCloud as the place to write, which was wrong — corrected
2026-09-13 against CLAUDE.md, which is the authority here.

`INDEX.md` (hub) · `TASKS.md` (one checkbox list) · `CONVENTIONS.md` (Tim's
corrections) · `Projects/<name>.md` (27 notes, one screen each) · `Log/YYYY-MM.md`
(append-only, dated decisions) · `DESIGN.md` (how it works).

History lives in `vault/` in the `claude-config` repo — `sync.sh` pushes it,
`install.sh` restores it, and that is what survives a dead machine. Run
`~/Git/claude-config/sync.sh "<message>"` at the end of a session that changed
anything.

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
