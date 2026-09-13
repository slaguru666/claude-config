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

**Current state** — Phase 2 complete (2026-09-12). Portable schema (`src/data/schema.mjs`),
standalone validator (`src/data/validate.mjs`) and conformance fingerprinting
(`src/data/fingerprint.mjs`) agree with Foundry v14.363 on **zero differences**.
349 tests passing. Both real boards validate with no errors and no coercions.
Committed `3ee09e1`, pushed. Live module files untouched.

**Next steps**
- Phase 3: extract the controller incrementally, subsystem by subsystem, with live
  checks between — a wide refactor built on the Phase 2 schema and validator
- iPad storage durability testing (contracts §5)
- File-exchange validation (§4, §9)
- Local-network sync for offline iPads (§8) — decided out of scope for Phase 2

**Key decisions**
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

Related: [[custodians-ringbrp]], [[oneoffgames-vps]]
