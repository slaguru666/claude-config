---
name: corkboard-module
description: "Corkboard — Tim's Foundry VTT investigation-board module at ~/Git/corkboard; architecture, trust model, and the deploy path that keeps the live world up."
metadata: 
  node_type: memory
  type: project
  originSessionId: 1c117e42-e3c4-45cf-af54-8456a315b23b
  modified: 2026-09-13T09:44:53.616Z
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

**Verifying a gesture against a live server** is a technique this module needed
and the harness has sharp edges, all written up in
`docs/verification/2026-09-13-rebase-live.md`. Read that before driving the
board with synthetic events — the four that cost real time:

- The **content subtree is replaced on every render**, so a viewport reference
  looked up once and reused is detached after the first commit. Events sent to
  it reach nothing, and it reports as *"the gesture declined to claim"* rather
  than as an error. Re-query for every event.
- `setPointerCapture` throws for a fabricated pointer id; stub it and restore it
  after. Nothing depends on capture for recovery.
- Anything using `document.elementFromPoint` (string release, card hit tests)
  needs the point inside the **sheet window**, which keeps the size it opened at
  — enlarging the browser pane does not enlarge it. `app.setPosition` does.
- Player-only behaviour is reachable without a second login: the board's own
  **Player preview** button puts a GM's sheet into player mode.

Toolbar controls (pen, shape tools, player preview) exist only in
`board-edit.hbs` — rendering the *parent journal sheet* embeds the page read-only
through `board-view.hbs`, where no shape gesture is ever claimed. Open the
page's own sheet.

Reviews from both Codex and an internal pass live in `docs/reviews/` with ranked
feature proposals. Related: [[afterimage-scenario]], [[infra-oneoffgames-vps]],
[[feedback-codex-review-loop]].
