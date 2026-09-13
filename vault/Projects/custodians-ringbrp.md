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

**Current state** — playable, and now guarded. **20 build guards** under `npm run check`,
each one a claim about the game that is re-measured on every build; `docs/REVIEW_LOG.md`
is at **R-297** and is the reasoning behind every one of them. Scenarios: `LAST_ADMISSION`,
`OPEN_DAY`, `THROUGH_TRAIN` and **CLEAN GROUND** (v0.20.1, **nine** desk playtests, booked
for Contingency 2027 slot 9). `docs/BESTIARY.md` is generated from the game and checked
against it. **CLEAN GROUND's published figures are now held in both directions**:
`check-packs` holds the baseline against the harness, `check-cited` holds the prose against
the baseline, and 151 figures across six artifacts carry citation markers.

**Next steps** — **CLEAN GROUND needs a run with human beings**; that is the only thing
left before convention-ready and no desk pass can replace it. Four branches remain unplayed
after nine passes: a fight the players choose, Ashcroft accepting THE OFFER *and* being
taken, and a hollow man that succeeds at the swap. Elsewhere: splitting `ringbrp.mjs`;
anatomy tables for non-human shapes, which the bestiary names as its own known gap.

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
- 2026-09-13 — **Derived figures resolve against the rule; sampled figures against a
  baseline.** A figure that is a pure function of `rules.mjs` is enumerated on every build
  and never stored: a stored copy is a cache that can go stale, and it arrives with an
  `--update` able to silence a real disagreement between document and game. A sampled figure
  is expensive and noisy to re-run, so it is recorded deliberately. `check-cited`'s ARTIFACTS
  map takes either kind and a citation does not know which it got.
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

- 2026-09-13 — **A guard measured at a default ceiling is a guard that lies quietly.**
  `simulate.mjs` calls `runFight` with no options, so every published fight figure ran at a
  40-round cap and `runFight` returns who is standing rather than a truncation flag. One
  table understated a wipe rate by fourteen points with 29% of runs never finishing. Measure
  at a cap nothing reaches and refuse to record a truncated sweep — a warning on a number
  that is already wrong is a number that gets quoted.
- 2026-09-13 — **A unique-match assertion protects against editing the wrong text and not
  at all against inserting in the wrong place.** Cost a numbered list that ran 1,2,3,4,6,5
  under a heading saying "five", through two versions and five guard additions.
- 2026-09-13 — **Prose that counts itself is not a format**, so no checker sees it. The cold
  read — reading the document as a GM meeting it 30 minutes before a slot — found in one
  minute what seven passes of dice never touched. Keep doing it.
- 2026-09-13 — **A figure quoted in a fix list acquires confidence every time it is
  restated.** A wrong number there propagated to a second reader who handed it back with
  more confidence than it was written with. Correct the record, not only the document.

Related: [[rpg-skill]], [[gitea-timevans]], [[codex-cli]]
