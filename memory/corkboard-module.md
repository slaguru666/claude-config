---
name: corkboard-module
description: "Corkboard — Tim's Foundry VTT investigation-board module at ~/Git/corkboard; architecture, trust model, and the deploy path that keeps the live world up."
metadata: 
  node_type: memory
  type: project
  originSessionId: 1c117e42-e3c4-45cf-af54-8456a315b23b
  modified: 2026-09-11T23:37:39.308Z
---

Corkboard is a standalone Foundry VTT v14 module at `~/Git/corkboard`
(github slaguru666/corkboard), built 2026-09-11/12. A board is a
**JournalEntryPage of subtype `corkboard.board`** — there is no sidebar tab and
no scene-control button, so nothing is visible until a board page is created.
That surprised Tim on first use; lead with it when explaining the module.

**Architecture worth not rediscovering:** `sheet.mjs` is the only writer, via
`#commit`; `board-ops.mjs` holds pure functions returning flat Foundry update
payloads; `visibility.mjs` is the single gate where a player's board differs
from the GM's. The module deliberately opens **no custom socket** — features
that need to reach other clients (the spotlight) are stored as document state
so Foundry's own broadcast carries them. Keep that property.

**Trust model, decided and documented:** player edit grants real Foundry OWNER
on the page, because Foundry checks ownership server-side. The in-sheet rules
and the delete guard are accident guards, not a boundary — a player at a console
can write anything to that page. Hidden cards and GM notes are client-side
filtering only. Tim accepted this for in-person convention play; do not describe
these as secure.

**Deploy:** `./deploy.sh --force`. Corkboard ships no compendium packs, so
deploying over the running server is safe — unlike the afterimage module, whose
LevelDB packs require returning the world to Setup first. Reload the world to
pick up new code.

Reviews from both Codex and an internal pass live in `docs/reviews/` with ranked
feature proposals. Related: [[afterimage-scenario]], [[infra-oneoffgames-vps]].
