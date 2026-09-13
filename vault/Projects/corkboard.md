---
type: project
status: active
repo: slaguru666/corkboard
path: ~/Git/corkboard
updated: 2026-09-13
---

# Corkboard

**What it is** — A standalone Foundry VTT v14 investigation-board module. A board
is a JournalEntryPage of subtype `corkboard.board` — there is **no sidebar tab and
no scene-control button**, so nothing is visible until a board page is created.
That surprises people on first use; lead with it.

**Where it lives** — `~/Git/corkboard`, remote `slaguru666/corkboard`. Deploy with
`./deploy.sh --force`, then reload the world. Reviews in `docs/reviews/`.

**Current state** — Phase 3 viewport and gesture arbitration complete
(2026-09-13). `BoardController` and a Foundry-free `GestureArbiter` extracted;
every element drag now **rebases on concurrent edits** — a drag means "from where
this is now", so another player's move is never silently undone. 448 tests.
Head `cde4cff`, pushed, deployed.

Five Codex review rounds on this work found **six defects**, all fixed and each
verified against the live server. **All eight `reacquire` implementations now
have a live pass** — card move/resize, zone move/resize, shape move, reshape,
string, pen, shape creation. Written up in
`docs/verification/2026-09-13-rebase-live.md`; reviews in `docs/reviews/`
(8–17).

**Next steps**
- Phase 3 remaining: cards and strings, then shapes and ink, then dialogs and IO
- Phases 4–6: transfer and offline, sync proof, opt-in sharing
- iPad storage durability testing (contracts §5), and Tim's iPad test of
  https://web.oneoffgames.com/corkboard-spike/
- File-exchange validation (§4, §9)
- Local-network sync for offline iPads (§8) — out of scope for Phase 2

**Key decisions**
- 2026-09-13 — **All drags rebase on concurrent edits**, cards and zones included
  (Tim's call). A clamped drag must rebase from the *pointer*, never from the
  clamped preview — that distinction was a real defect → [[2026-09]]
- 2026-09-13 — Gesture recovery is driven by `draw()` → `reacquire()`, **not** by
  `lostpointercapture`, which fires for touch and pen whatever the gesture is
- 2026-09-12 — Dual schema definitions with conformance testing → [[2026-09]]
- 2026-09-12 — **Never stricter than Foundry.** Foundry's NumberField is nullable,
  so `pin.x = null` is valid; entity keys are unconstrained, so hand-authored keys
  like `base1` must be accepted. The only real key constraint is DOM safety.
- Player edit grants **real Foundry OWNER** on the page, because Foundry checks
  ownership server-side. The in-sheet rules and delete guard are accident guards,
  not a boundary. Accepted for in-person convention play — never describe as secure.
- No custom socket. Features that must reach other clients are stored as document
  state so Foundry's own broadcast carries them. Keep that property.

**Gotchas**
- `sheet.mjs` is the only writer, via `#commit`. `board-ops.mjs` is pure functions
  returning flat update payloads. `visibility.mjs` is the single gate between a
  player's board and the GM's.
- Foundry merges field class defaults onto instances — comparing `field.options`
  alone produces phantom differences.
- Safe to deploy over a running server (no compendium packs), unlike [[afterimage]].
- **Driving the board with synthetic events has sharp edges** — all four written
  up in `docs/verification/2026-09-13-rebase-live.md`. The worst: the content
  subtree is replaced on every render, so a reused viewport reference is detached
  after the first commit, and events sent to it report as *"the gesture declined
  to claim"* rather than as an error.
- Toolbar controls (pen, shape tools, Player preview) exist only in
  `board-edit.hbs`. Rendering the **parent journal sheet** embeds the page
  read-only — open the page's own sheet.
- **Player preview** puts a GM's sheet into player mode; no second login needed
  to test player-only behaviour.
- **A pinned background needs a pinned colour.** Two editor fields set a light
  background and let the colour inherit; under the dark theme that is near-white,
  so note bodies were invisible. ProseMirror styles its own `.editor-content`, so
  the host's colour does not reach it.
- The card editor opens from the card's **right-click menu**, or automatically
  after *Add note* — double-click only opens *link* cards.

Related: [[custodians-ringbrp]], [[oneoffgames-vps]]
