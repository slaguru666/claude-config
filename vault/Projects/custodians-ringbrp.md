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

**Current state** — playable and guarded. **21 build guards** under `npm run check`, each a
claim about the game re-measured on every build. **`docs/REVIEW_LOG.md` (at R-299) holds the
reasoning behind all of them** and is the thing to read before re-deciding anything here.
Scenarios: `LAST_ADMISSION`, `OPEN_DAY`, `THROUGH_TRAIN`, **CLEAN GROUND** (v0.23, eleven
desk passes, Contingency 2027 slot 9), whose published figures are held in both directions —
`check-packs` holds the baseline against the harness, `check-cited` the prose against the
baseline, 162 figures cited across six artifacts, and `check-figures` reads the figures rather than the markers so a measured number with nothing holding it stops the build.

**Next steps** — **CLEAN GROUND needs a run with human beings, and that is now the only thing
left on its list.** Pass 11 closed the last desk-reachable branch; every one of the original
four has been played. Then splitting `ringbrp.mjs`, and anatomy tables for non-human shapes —
the bestiary's own known gap. The twenty-first guard is built (`check-figures`).

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
- 2026-09-13 — **A verified figure lends its credibility to the sentence it stands in.**
  Re-deriving a peer's 4.90% exactly and inheriting their unchecked premise with it shipped a
  false claim. The arithmetic was never the part that could be wrong. The cheap check is
  *what does this figure need to be true in order to matter?* — sharper still, the scenario
  had no roll for it at all, so it was a right number with no question attached and the
  premise arrived to give it one.
- 2026-09-13 — **Two rules each right can be a hole between them.** `check-cited` refuses a
  citation against a sample maximum because it moves a third on a re-seed; the document printed
  that same figure bare. Refusing the citation while printing the number left the least stable
  figure in the suite as the only one nothing held. Guards need to be read against each other,
  not only against the thing they guard.
- 2026-09-13 — **A guard checks what is marked; the defect lives in what is not.** A stale
  "median 24 rounds" survived every pass because it carried no citation marker, and
  `check-cited` can only resolve markers that exist. Fifth reader caught unable to see its
  own format, after cast declarations, beat tags, citation markers and `POWER:`.
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
