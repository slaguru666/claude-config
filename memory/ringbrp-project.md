---
name: ringbrp-project
description: "THE CUSTODIANS (dir: ringbrp) — a BRP Foundry system grown out of the 1984 Ringworld RPG; rules.mjs is the sole rule authority and has superseded the old design-doc rulings"
metadata: 
  node_type: memory
  type: project
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-09-09T19:30:00.000Z
---

Started 7 August 2026. **Two repositories, and the distinction matters:**

- `~/FoundryVTT/Data/systems/ringbrp/` → `slaguru666/RingBRP` — the playable Foundry system.
  `rules.mjs` there is the ONLY rule authority. Scenarios live inside it at `docs/scenarios/`
  (`LAST_ADMISSION`, `OPEN_DAY`, `THROUGH_TRAIN`), which is why searching Gitea for a scenario
  repo finds nothing. `docs/GM_SCREEN.md` is the table-facing sheet, every figure verified by
  running the functions. Guards run under **bun**: `npm test` → `bun run check` → eight guards.
  Bare `bun test` runs bun's own runner and finds nothing — not the guards.
- `~/RingBRP/` → `slaguru666/ringbrp-design` (public, since 9 Sep 2026) — the design corpus:
  the bible, six rules specs, 26 review briefs, and `make-loom-board.mjs`. **Gitea has
  push-to-create disabled and there is no API token on the Mac**, so a new repo has to be
  created in the web UI first. `.gitignore` holds back the nine scanned Chaosium books
  (~133 MB) and `extracted/` (882 MB of page images, rebuildable via `extract_all.sh`) —
  4 MB published instead of a gigabyte.

## Where it stands
- **Source corpus**: all 9 Ringworld PDFs Docling-extracted to `~/RingBRP/extracted/`.
- **Setting bible**: `~/RingBRP/RINGWORLD_BIBLE.md`.
- **Rules spec**: six versions, v0.6 current. Each reviewed adversarially by Codex; full history in
  `~/RingBRP/design/REVIEW_LOG.md`.
- **Foundry system**: `ringbrp` v0.6.0, verified running in a live Foundry v14 instance with a
  world called `ringbrp-slice`. Four pregens, four NPC statblocks, 49 skills, 20 weapons,
  site/hazard tables and a 7-page GM journal, all in LevelDB compendia.

## The system is now THE CUSTODIANS — and rules.mjs is the only authority

`~/FoundryVTT/Data/systems/ringbrp/rules.mjs` opens "THE CUSTODIANS — canonical rule
functions" and is imported by both the runtime and the pack builder *so the packs cannot be
built under one rule and played under another*. Its header records that five separate defects
came from a formula written twice and changed once. **Read it before quoting any rule.**

Four rulings that older notes and the `design/` specs still carry have been superseded in
code — verified 9 September 2026:

| the old note | what `rules.mjs` implements |
| --- | --- |
| HP = `CON + MAS` (1984) | `hitPointsFor` = `ceil((CON + SIZ) / 2)`, standard BRP |
| Major Wound = `max(9, ceil(HP/3))` | `majorWoundFor` = `ceil(HP / 2)` |
| "No hit locations. Final." | locations are in: `locationMaxHp`, `locationEffectsFor`, `locationArmourFor`, `COVERAGE` |
| home-world gravity *determines* Reflex vs Deliberate | `styleFor` — the agent chooses; home worlds are gone |

The header names the first two explicitly as the builder-side copies that drifted. `design/`
holds six rules specs addressed to Codex; they are review history, **not** the current rules.

The system now carries far more than those specs describe: coherence bands, panic and relief,
a return clock and extraction cost, space combat with range bands / heat / stations, burst
fire and fire modes, sustain, sights and lighting, a contact/impression social ladder, shields,
two-weapon, falling and asphyxia.

## Scenarios

Three Custodians scenarios live *inside the system*, at `docs/scenarios/`, not in a scenario
repo — which is why searching Gitea and GitHub for them finds nothing: `LAST_ADMISSION.md`
(prologue), `OPEN_DAY.md` (prologue), `THROUGH_TRAIN.md` (the crossing starter — the western,
a train looping the same four minutes since 1881). Each has a `tools/scenario-*.mjs` builder
and a `packs/` compendium.

## Hard-won lessons
- **Rewards accelerate; they never gate.** Two versions failed because a scenario-critical object
  sat behind a probability gate (the second time at P=1.7%). Anything on the critical path must be
  reachable by some route with probability 1.
- **Derive HP from the weapon damage ladder, not the other way round.** The 1984 damage values are
  calibrated to a ~26-point pool; halving HP collapses the ladder into one-hit kills.
- **Foundry LevelDB packs**: the parent document's `items` / `pages` / `results` array must hold
  **ID strings, not objects**. Writing objects yields a pack that loads with zero embedded
  documents and no error. This cost real time; the server log message about "undefined embedded
  records" is the tell.

## Working method that works
Claude writes the spec, Codex reviews it adversarially via `codex exec`, Claude verifies every
checkable claim against the source corpus before accepting it. Across six rounds every Codex
factual claim that was tested held up — but Claude's own recomputation caught four wrong
probabilities Claude had published, so verify both sides.

Related: [[rpg-skill]]
