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
  corpus: the bible, six rules specs, 26 review briefs. `.gitignore` holds the scans back.

**Current state** — playable and guarded. **20 build guards** under `npm run check`, each a
claim about the game re-measured on every build. **`docs/REVIEW_LOG.md` (at R-297) holds the
reasoning behind all of them** and is the thing to read before re-deciding anything here.
Scenarios: `LAST_ADMISSION`, `OPEN_DAY`, `THROUGH_TRAIN`, **CLEAN GROUND** (v0.20.1, nine
desk passes, Contingency 2027 slot 9), whose published figures are held in both directions —
`check-packs` holds the baseline against the harness, `check-cited` the prose against the
baseline, 151 figures cited across six artifacts.

**Next steps** — **CLEAN GROUND needs a run with human beings**; no desk pass replaces it.
Four branches unplayed after nine: a fight the players choose, Ashcroft accepting THE OFFER
*and* being taken, a hollow man that succeeds at the swap. Then splitting `ringbrp.mjs`, and
anatomy tables for non-human shapes — the bestiary's own known gap.

**Key decisions**
- 2026-09-09 — **`rules.mjs` is the ONLY rule authority**, imported by runtime and pack
  builder alike, so packs cannot be built under one rule and played under another. Read it
  before quoting any rule; the `design/` specs are review history, **not** current rules.
  Superseded there: HP is `ceil((CON+SIZ)/2)`, Major Wound `ceil(HP/2)`, hit locations are
  in, the agent chooses Reflex vs Deliberate, home worlds are gone.
- 2026-09-13 — **A reader that cannot see a marker is worse than no reader**, because whoever
  wrote it believes the thing is declared. Every marker reader tolerates case and spacing and
  carries a looser counter that names what the strict one could not parse.
- 2026-09-13 — **`docs/scenarios/` holds scenarios, playtest records and art sheets**, and
  only the first kind has live rolls. Classified by the document's own H1, never its
  filename; an unclassified document is fatal rather than silently dropped.
- 2026-09-13 — **Derived figures resolve against the rule, sampled figures against a
  baseline.** A pure function of `rules.mjs` is enumerated every build and never stored: a
  stored copy is a cache that goes stale, and it arrives with an `--update` able to silence a
  real disagreement between document and game.
- 2026-09-13 — **Measure at a cap nothing reaches, and refuse to record a truncated sweep.**
  `runFight` reports who is standing, not that it ran out of rounds, so every published fight
  figure had run at a 40-round default; one table understated a wipe by fourteen points with
  29% of runs unfinished.
- **Rewards accelerate, they never gate.** Two versions failed with something on the critical
  path behind a probability gate (once at P=1.7%).

**Gotchas**
- Guards run under **bun**: `npm test` → `bun run check`. Bare `bun test` runs bun's own
  runner and finds nothing.
- Foundry LevelDB packs: parent `items`/`pages`/`results` arrays must hold **ID strings, not
  objects**. Objects yield a pack that loads with zero embedded documents and no error.
- `check-scenarios` sweeps `tools/scenario-*` into the scenario corpus, so a tool with that
  prefix has its prose read as a scenario's. Cost one rename already (`declared-cast.mjs`).
- Derive HP from the weapon damage ladder, not the reverse — halving HP collapses the 1984
  damage values into one-hit kills.

Working-practice lessons this project taught live in the memory files, not here:
`feedback-assert-where-not-just-what` (a unique match protects the text you edit, never where
new text lands; and the cold read that found what seven passes of dice did not) and
`feedback-concurrent-agents` (never repeat a peer's figure back to them).

Related: [[rpg-skill]], [[gitea-timevans]], [[codex-cli]]
