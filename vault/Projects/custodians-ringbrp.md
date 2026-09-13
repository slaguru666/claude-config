---
type: project
status: active
repo: slaguru666/RingBRP + slaguru666/ringbrp-design
path: ~/FoundryVTT/Data/systems/ringbrp + ~/RingBRP
updated: 2026-09-13
---

# The Custodians (RingBRP)

**What it is** — A Ringworld BRP Foundry system, started 7 August 2026, now named
**THE CUSTODIANS**. Two repositories, and the distinction matters.

**Where it lives**
- `~/FoundryVTT/Data/systems/ringbrp/` → `slaguru666/RingBRP` — the playable system.
  Scenarios live *inside it* at `docs/scenarios/`, which is why searching Gitea for a
  scenario repo finds nothing. `docs/GM_SCREEN.md` is the table-facing sheet.
- `~/RingBRP/` → `slaguru666/ringbrp-design` (public since 9 Sep 2026) — the design
  corpus: the bible, six rules specs, 26 review briefs. `.gitignore` holds back the
  scanned books and extracted page images.

**Current state** — v0.6.0 running in a live Foundry v14 world (`ringbrp-slice`).
Four pregens, four NPC statblocks, 49 skills, 20 weapons, site/hazard tables, a
7-page GM journal, all in LevelDB compendia. Three scenarios written:
`LAST_ADMISSION`, `OPEN_DAY`, `THROUGH_TRAIN`. Hit-location system shipped v1.7.0;
winged-creature grounding shipped v1.7.3.

**Next steps** — none outstanding; the system is playable.

**Key decisions**
- 2026-09-09 — **`rules.mjs` is the ONLY rule authority**, imported by both runtime
  and pack builder so packs cannot be built under one rule and played under another.
  Five defects came from a formula written twice and changed once. Read it before
  quoting any rule. The `design/` specs are review history, **not** current rules.
- Four superseded rulings: HP is `ceil((CON+SIZ)/2)` not `CON+MAS`; Major Wound is
  `ceil(HP/2)` not `max(9, ceil(HP/3))`; hit locations **are** in; the agent chooses
  Reflex vs Deliberate — home worlds are gone.
- **Rewards accelerate, they never gate.** Two versions failed because something on
  the critical path sat behind a probability gate (once at P=1.7%).

**Gotchas**
- Guards run under **bun**: `npm test` → `bun run check`. Bare `bun test` runs bun's
  own runner and finds nothing.
- Foundry LevelDB packs: parent `items`/`pages`/`results` arrays must hold **ID
  strings, not objects**. Objects yield a pack that loads with zero embedded
  documents and no error.
- Derive HP from the weapon damage ladder, not the reverse — halving HP collapses
  the 1984 damage values into one-hit kills.

Related: [[rpg-skill]], [[gitea-timevans]], [[codex-cli]]
