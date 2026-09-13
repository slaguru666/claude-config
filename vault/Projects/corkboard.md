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

**Current state** — Phase 3 gesture extraction complete, and **the standalone app
now runs** (2026-09-13). `app/index.html` is a browser page with no Foundry that
creates, names, opens and deletes boards; adds cards and zones; drags, resizes,
ties string, draws and rubs out; and reopens a board with everything still there.
Verified live against a 21-commit board. It is not a second corkboard — the
renderer, stylesheet, gestures and arithmetic are the module's own files, reached
through the `BoardHost` seam. 781 tests. Head `5246a85`, pushed.

New: `src/data/apply.mjs` (the trust boundary for flat `system.*` payloads),
`src/app/{commits,store,idb,writer-lock,host,board-view,shelf,selection,notify,
icons,main}.mjs`, `styles/app.css`. `src/board/gesture-order.mjs` holds the one
copy of the arbitration order, and `view-gestures.mjs` the pan — both hosts go
through them. `build.mjs` keeps `src/app` out of the module's dist.

Run it: `npx http-server . -p 8791 -c-1`, open `/app/index.html`.

Codex rounds 18–23, all on the shape minimum. The same defect kept reappearing
because each guard measured its own convenient proxy: the box diagonal, then the
rounded box, then fractions that can exceed 1. `lineLength()` is now the single
definition, and creation holds a line's ends inside its box. Round 23 also fixed
a pre-existing undo that could restore half an old line against half a new one
and leave it with no length. Reviews in `docs/reviews/` (18–23).

**Next steps**
- **App slice 2** — the shared allow-list sanitiser used by BOTH hosts, and a
  contenteditable rich-text editor (`<prose-mirror>` is Foundry's). Contracts §2
- **App slice 3** — asset ids, blob store, the display-time image resolver
- Then: dialogs and IO, import/export, and the `.corkboard` bundle (phase 4)
- Pen-tap dot defect — spawned as task `task_c0e721aa`, awaiting Tim's click
- Phases 4–6: transfer and offline, sync proof, opt-in sharing
- iPad storage durability testing (contracts §5), and Tim's iPad test of
  https://web.oneoffgames.com/corkboard-spike/
- Deferred from review 21: require `shape` whenever `setShapeBox` is given size
  keys (today it silently falls back to a zero floor); `reshape` previews nothing,
  so the clamp is invisible until release

**Key decisions**
- 2026-09-13 — **The multi-tab lock is `navigator.locks`, not BroadcastChannel**,
  amending contracts §5 in place. A BroadcastChannel post from `pagehide` is
  queued as a task and the document dies before it runs, so closing the tab
  holding a board left the other read-only for good. Every decision in §5 stands;
  only the mechanism moved → [[2026-09]]
- 2026-09-13 — **The app shows a change only after it is stored.** A commit
  computes the next board, writes it, and then draws it. Showing first is faster
  by one IndexedDB round trip and lies whenever the write fails → [[2026-09]]
- 2026-09-13 — **Writes are declared as operation lists, never handed-out
  transactions.** Makes "the board and its commit land together" structural, and
  sidesteps a transaction held across an `await` being closed by the browser
- 2026-09-13 — **The arbitration order lives in one place** (`gesture-order.mjs`).
  Two array literals in two hosts agree only while somebody remembers they must
- 2026-09-13 — **A broken module has no data model, so nothing is cleaned.** I
  concluded Foundry does not enforce a TypedObjectField member's min/max after
  probing a module whose imports were 404ing from a partial deploy: the subtype
  was never registered. Missing schema defaults are the tell. Foundry and
  `validateBoard` agree; deploy the build, never the files you touched → [[2026-09]]
- 2026-09-13 — **One definition of a line's length**, asked by creation and
  resizing alike (`lineLength` in `board-ops.mjs`). Two rounds of review found
  the same defect twice because the two guards each measured their own
  convenient proxy → [[2026-09]]
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
