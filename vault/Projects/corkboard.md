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

**Current state** — Phase 3 gesture extraction complete (2026-09-13). Cards and
strings (`card-gestures.mjs`), shapes and ink (`ink-gestures.mjs`) and zones
(`zone-gestures.mjs`) are all out of `sheet.mjs`, which has dropped 2821 → ~2409
lines. The controller owns a `BoardHost` seam so the handlers never touch
Foundry. 614 tests. Head `d9fc738`, pushed, deployed.

Codex rounds 18–21 on this work. Round 21 found the shape minimum-size guard
from `33910fd` was itself defective — it measured a line by its **box diagonal**,
which is the line's length only while the ends sit in opposite corners. Fixed by
measuring endpoint displacement; verified live on `cb2`. Two existing tests were
passing for the wrong reason (horizontal fixture, diagonal claim) and were
corrected. Reviews in `docs/reviews/` (18–21), live runs in
`docs/verification/`.

**Next steps**
- Phase 3 remaining: dialogs and IO, IndexedDB commits, shared sanitiser, board
  create/list/name/delete
- **Standalone app shell** — spawned as task `task_a683e22c`, awaiting Tim's click
- Phases 4–6: transfer and offline, sync proof, opt-in sharing
- iPad storage durability testing (contracts §5), and Tim's iPad test of
  https://web.oneoffgames.com/corkboard-spike/
- Deferred from review 21: require `shape` whenever `setShapeBox` is given size
  keys (today it silently falls back to a zero floor); `reshape` previews nothing,
  so the clamp is invisible until release

**Key decisions**
- 2026-09-13 — **A line's minimum is measured between its ends, not across its
  box.** The box is only the line's bounding box at creation; after a nudge it can
  gain a side the line never had, and a guard reading the diagonal will spend it
  → [[2026-09]]
- 2026-09-13 — **Per-tool ink settings are read once, together, at gesture start.**
  `inkColor`/`inkWidth` live per tool, so capturing the tool at press and the
  colour at release marries one tool's identity to another's settings
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
