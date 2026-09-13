---
name: scenario-forge
description: Compiler turning house-format scenario Markdown into a Foundry module + four generated Corkboard boards; design approved, no code yet
metadata:
  type: project
---

`~/Git/scenario-forge` — a compiler for Tim's house RPG scenario format. Markdown
+ YAML front-matter + a thin `scenario.config.mjs` becomes an installable Foundry
module (journals, handouts, actors, scenes) plus four Corkboard boards generated
from tables the scenarios already contain: Clue Trail → case board, NPC Roster →
cast board, Countdown → timeline board, plus a zones-only player board. It
refuses to build a non-conforming scenario.

As of 2026-09-13: **design approved, spec committed (`e405c38`), no code, no
remote yet.** Full design in the repo's
`docs/superpowers/specs/2026-09-13-scenario-forge-design.md`; project state and
decisions in the vault's `Projects/scenario-forge.md` — the vault wins on any
disagreement. See [[claude-memory-vault]], [[corkboard-module]], [[rpg-skill]].

Two facts that cost real time to establish and are easy to undo by accident:

- **Adventure re-import is destructive.** Foundry's `prepareImport` partitions on
  `collection.has(d._id)` and updates with `{diff: false, recursive: false}`, so
  with deterministic ids a re-import replaces a board page wholesale — every card
  the GM moved or added, gone, no prompt. Corkboard's `sf-`-prefix re-sync exists
  because of this; it is not a convenience.
- **The Foundry CLI is deliberately not in the pipeline.** Packing writes LevelDB
  directly because the CLI splits a scene's `levels` into their own sublevel keys
  and v14 synthesises a blank level instead, losing the background art.
