---
type: design
status: built
created: 2026-09-13
updated: 2026-09-13
---

# Claude Memory Vault — Design

How Claude records the work we do together as plain Markdown in this vault, so that
context survives the loss of any machine, database or tool.

## Purpose

Claude's working memory currently lives in three places, none of them yours:

- `claude-mem` — a local observation database on each machine
- `Graphiti` — a knowledge graph at `graphiti.timevans.uk`
- `~/.claude/projects/-Users-timevans/memory/` — per-machine Markdown files

If any of those is lost, the record of *what we were building, why, and what came next*
goes with it. This vault becomes the durable, human-readable layer underneath them.

## Non-goals

This is **not** a copy of the work. It never holds:

- source code (beyond a named function or file path)
- scenario text, handouts, documents, or any authored content
- credentials, tokens, passwords or keys
- generated assets, images, or exports

Those live in their repos. This vault holds only the **map**: what exists, where it is,
what state it is in, what happens next, and why we decided things that way.

Rule of thumb: if losing this note would cost you *understanding*, it belongs here.
If losing it would cost you *work*, it belongs in a repo.

## Location

Three copies, one writer.

| Copy | Path | Role |
|---|---|---|
| **Canonical** | `~/Vault/slavault/Ai/Claude/` | The vault Tim actually works in. Read and write here. |
| **History** | `vault/` in the `claude-config` repo | What survives a dead machine, and what MINI-S reads. |
| **Mirror** | the iCloud vault's `Ai/Claude/` | One-way, so `TASKS.md` is readable on the phone. Read-only in practice. |

`~/Git/claude-config/sync.sh` moves canonical → history and canonical → mirror in
one pass, with `--delete` on both, so the canonical copy is the only thing that
decides content. `install.sh` restores history → canonical on a fresh machine, as an
overlay with no `--delete`, so an install can never destroy newer local notes.

A machine with no Obsidian vault (MINI-S) skips both the copy and the mirror, leaving
the repo copy intact, and reads `~/Git/claude-config/vault/` directly.

**Never edit the iCloud copy**, including on the phone — the next sync overwrites it.
Durability no longer depends on iCloud; git is the durable layer now.

**Concurrency is the weak point, not sync.** The scheme assumes one writer at a time,
and several Claude sessions write it at once. Git catches nothing here: a session that
reads a note, edits its own copy and writes it back produces no conflict, just a silent
overwrite — or, when both append, a silently doubled file. `Log/` is safe because it is
append-only; project notes are not. The working rules are in `CONVENTIONS.md` under
*Writing to the vault*. A `sync.sh` check for repeated headings would make this
self-detecting and has not been built.

## Structure

```
Ai/Claude/
  DESIGN.md              This document — how the system works
  INDEX.md               The hub. Every project, grouped, one line each
  TASKS.md               Single active task list, checkboxes, phone-friendly
  CONVENTIONS.md         Working preferences Claude must honour
  Projects/
    corkboard.md         One living note per project
    ringbrp.md
    ...
  Log/
    2026-09.md           Append-only monthly log of decisions and session summaries
  Archive/
    TASKS-2026-08.md     Completed tasks, rolled monthly
```

Four note types, each with one job:

| Note | Job | Changes |
|---|---|---|
| `INDEX.md` | Find anything in 10 seconds | Rarely — new projects only |
| `Projects/*.md` | Current truth about one project | Overwritten in place |
| `TASKS.md` | What's outstanding, everywhere | Constantly |
| `Log/*.md` | What happened and why, dated | Append-only, never edited |

The split matters for sync: the file that changes most (`TASKS.md`) is small, and the
file that holds history (`Log/`) is append-only, so an iCloud conflict can duplicate a
line but can never silently lose one.

## Project note format

Fixed sections. Target one screen; if it won't fit, trim rather than grow.

```markdown
---
type: project
status: active | dormant | complete
repo: slaguru666/corkboard
path: ~/Git/corkboard
updated: 2026-09-13
---

# Corkboard

**What it is** — Foundry VTT investigation board module. A board *is* a journal page.

**Where it lives** — `~/Git/corkboard`, remote `slaguru666/corkboard`.
Deployed to `~/FoundryVTT/Data/modules/corkboard`.

**Current state** — Phase 2 complete: portable schema, validator and conformance
testing, 349 tests passing, committed 3ee09e1.

**Next steps**
- Phase 3: extract the controller incrementally, subsystem by subsystem
- Decide on iPad storage durability testing
- Decide on local-network sync for offline iPads

**Key decisions**
- 2026-09-12 — Dual schema definitions with conformance testing → [[2026-09]]
- 2026-09-12 — Governing rule: "never stricter than Foundry" → [[2026-09]]

**Gotchas** — no custom socket; player-edit grants real OWNER.
```

## Task format

One file, one list. Each task links its project so the context is one click away.

```markdown
## Active
- [ ] Extract shared controller (Phase 3) [[corkboard]]
- [ ] Playtest DEAD AIR part 1 [[contingency-2027]]

## Blocked
- [ ] Local-network iPad sync — awaiting decision [[corkboard]]
```

Completed items move to `Archive/TASKS-YYYY-MM.md` at month end, so the live file stays
short enough to read on a phone.

## Write protocol

Claude writes automatically, without being asked, at three moments:

1. **A decision lands** — append a dated one-liner to `Log/YYYY-MM.md` and add a bullet
   under *Key decisions* in the project note.
2. **Work completes or changes state** — overwrite *Current state* and *Next steps* in
   the project note; tick or add tasks in `TASKS.md`; bump `updated:`.
3. **Session ends** — make sure the two above are true before stopping.

Constraints on every write:

- Never write a code block longer than five lines.
- Never write a secret. If a note needs to reference one, name its location only
  (e.g. "token in `~/.codex/auth.json`").
- Never create a note outside `Ai/Claude/`.
- Never delete a `Log/` entry. Corrections are new dated entries.
- Prefer editing an existing note over creating a new one.

## Read protocol

At session start Claude reads `INDEX.md` and, once the task is clear, the relevant
project note — a few KB, cheap. This runs alongside Graphiti and claude-mem, not
instead of them: those stay the fast recall layer, this is the durable one.

Wiring: a short block in `~/.claude/CLAUDE.md` giving the vault path, the four note
types, and the write constraints above. That file is already synced across machines via
the `claude-config` repo, so every session on every Mac picks it up.

## Sync and conflicts

iCloud Drive is the sync mechanism. LiveSync is installed in this vault but has no
CouchDB URI and is paused, so it is not in play.

Conflict exposure is kept low by design: small files, one project per file, append-only
history. All vault files are currently materialised on disk (no `.icloud` placeholders),
so Claude can read them without triggering a download.

No Dataview or Bases plugin is installed, so nothing here depends on them. The
frontmatter is there so that queries become possible later without a rewrite.

## Bootstrap

Seed from everything already recorded — `MEMORY.md`, claude-mem observations, Graphiti —
so the vault starts complete rather than empty. Roughly 27 project notes:

**Foundry / tabletop tooling** — corkboard, ringbrp, mapwright, blueprint-news,
gmtool-director, rpg-skill

**Conventions** — continuum-2026 (five games), contingency-2027 (ten slots, DEAD AIR
trilogy)

**Apps** — loom, masque, ambient-synth, esper, haunt, grimoire, nexus

**Tooling** — clipsync, midjourney-bridge, codex-ops-kit, notebooklm-cli,
local-llm-agent-stack, plugin-sync, canvas-oss-course

**Infrastructure** — minis (remote access, Docker stacks, browser automation),
gitea-timevans, oneoffgames-vps, graphiti

Finished projects get a full note with `status: complete` and a short *Current state* —
they are exactly what you'd want back after a loss.

Working preferences (push after commit, Semaphore Gitea URL, never `git add -A` with
agents running) go to `CONVENTIONS.md`, not to project notes.

## Open items

1. ~~MINI-S cannot reach the vault.~~ **Solved 2026-09-13** — the vault rides in
   the `claude-config` repo, which MINI-S already pulls over SSH from GitHub. No new
   repo, no new keys, no Gitea web-UI steps. This also gave the vault the version
   history iCloud never provided.
2. **Relationship to Graphiti.** Proposed: Graphiti stays the searchable recall layer,
   this vault is the canonical human-readable one. If they disagree, the vault wins.
3. ~~Vault has no version history.~~ **Solved 2026-09-13** by the same change —
   every sync is a commit, so rollback is `git checkout`.
