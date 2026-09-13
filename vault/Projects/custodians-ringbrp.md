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

**Current state** — playable, and now guarded. **19 build guards** under `npm run check`,
each one a claim about the game that is re-measured on every build; `docs/REVIEW_LOG.md`
is at **R-293** and is the reasoning behind every one of them. Scenarios: `LAST_ADMISSION`,
`OPEN_DAY`, `THROUGH_TRAIN` and **CLEAN GROUND** (v0.19.1, eight desk playtests).
`docs/BESTIARY.md` is generated from the game and checked against it.

**Next steps** — splitting `ringbrp.mjs`; anatomy tables for non-human shapes, which the
bestiary names as its own known gap.

**Key decisions**
- 2026-09-09 — **`rules.mjs` is the ONLY rule authority**, imported by both runtime
  and pack builder so packs cannot be built under one rule and played under another.
  Five defects came from a formula written twice and changed once. Read it before
  quoting any rule. The `design/` specs are review history, **not** current rules.
- Four superseded rulings: HP is `ceil((CON+SIZ)/2)` not `CON+MAS`; Major Wound is
  `ceil(HP/2)` not `max(9, ceil(HP/3))`; hit locations **are** in; the agent chooses
  Reflex vs Deliberate — home worlds are gone.
- 2026-09-13 — **A reader that cannot see a marker is worse than no reader**, because
  whoever wrote the marker believes the thing is declared. Every marker reader now
  tolerates case and spacing AND carries a looser counter that names what the strict one
  could not parse. Three readers broke on their own author describing the format inside it.
- 2026-09-13 — **`docs/scenarios/` holds scenarios, playtest records and art sheets**, and
  only the first kind has live rolls. Classified by the document's own H1, never its
  filename. An unclassified document is **fatal**, not silently dropped.
- **Rewards accelerate, they never gate.** Two versions failed because something on
  the critical path sat behind a probability gate (once at P=1.7%).

**Gotchas**
- Guards run under **bun**: `npm test` → `bun run check`. Bare `bun test` runs bun's
  own runner and finds nothing.
- Foundry LevelDB packs: parent `items`/`pages`/`results` arrays must hold **ID
  strings, not objects**. Objects yield a pack that loads with zero embedded
  documents and no error.
- `check-scenarios` sweeps `tools/scenario-*` into the scenario corpus, so a tool with that
  prefix has its prose read as a scenario's. Cost one rename already (`declared-cast.mjs`).
- Derive HP from the weapon damage ladder, not the reverse — halving HP collapses
  the 1984 damage values into one-hit kills.

Related: [[rpg-skill]], [[gitea-timevans]], [[codex-cli]]
