---
type: project
status: active
repo: slaguru666/scenario-forge
path: ~/Git/scenario-forge
updated: 2026-09-13
---

# scenario-forge

**What it is** — A compiler for the house scenario format. A scenario Markdown
document plus YAML front-matter plus a thin `scenario.config.mjs` becomes an
installable Foundry module: journals, handouts, actors, scenes, and four
generated [[corkboard]] boards. It **refuses to build** a scenario that does not
conform. The framework is a compiler, not a document — a style guide that is not
executed is a style guide that drifts, which is how six scenarios ended up with
three spellings of the same heading.

**Where it lives** — `~/Git/scenario-forge`, remote `slaguru666/scenario-forge`
(private). Spec at
`docs/superpowers/specs/2026-09-13-scenario-forge-design.md`, head `e405c38`, pushed.

**Current state** — Parser and validator built and pushed 2026-09-13 (`fbd7566`,
79 tests). `forge check <dir>` parses the house format and runs 15 rules; there is
no builder yet, so the report **is** the product. All six Continuum scenarios now
carry front matter and validate at `convention-ready`. **37 findings down to 18.** The spike is done and closed the one feasibility question (below).
[[afterimage]]'s `foundry/afterimage/build.mjs` is the seed: 211 lines of which
only 8 mention AFTERIMAGE, and `content/scenario.mjs` already treats the scenario
Markdown as the single source of truth. The engine is that generalised.

**The four boards** are built from tables the scenarios already contain: Clue
Trail -> case board (all hidden, `gmNote` carries the fallback), NPC Roster ->
cast board, Countdown -> timeline board, plus a near-empty player board with
zones only.

**Next steps** (spec §12)
- Foundry builder, regression target: reproduce AFTERIMAGE's current adventure
- Corkboard phase 1 (`src/data/index.mjs` barrel + `exports` map, provenance
  flag, re-sync) and the four board generators
- Acceptance test: build AFTERIMAGE, import into a scratch world, open the case
  board — the one thing the spike could not verify
- Adapters beyond `blade-runner` and `generic`
- Normalise the other five scenarios. Real editing, not a script
- Move `~/.claude/skills/rpg/assets/scenario-template.md` into `templates/` and
  have [[rpg-skill]] point at it. One template, not two copies drifting

**Key decisions**
- 2026-09-13 — **The clue Type column takes a qualifier.** C-01 found twelve
  violations across two scenarios and every one was the *format's* fault:
  `Essential (routes: Dallam · Ashford letters · Garratt's own notes)` says how
  else the clue can reach the table, which is the most useful thing in the row.
  A Type now opens with Essential or Optional and may qualify that freely;
  the parser splits `type` / `qualifier` / `typeRaw` so the annotation reaches
  the case board's gmNote instead of being deleted to satisfy a validator.
- 2026-09-13 — **A rule that cries wolf gets ignored, so both imprecise rules
  were narrowed rather than tuned.** R-01 counted every blockquote and reported
  a 24-sentence "read-aloud block" that was a GM aside (34 findings → 3); it now
  judges only blocks that say they are read aloud or sit under a heading that
  does. N-02 treated every `####` in an act as an NPC and reported AFTERIMAGE's
  numbered *location* "① The rig and the body" as missing from the cast (16 → 0);
  it now reads only headings beneath an `### NPCs` subsection. Both trade recall
  for precision on purpose. → [[2026-09]]
- 2026-09-13 — **The Scenario object is the seam.** Parsers know Markdown and
  nothing about Foundry; builders know Foundry and nothing about Markdown;
  adapters know one system and nothing about either. A bug in clue parsing
  cannot reach the packer.
- 2026-09-13 — **Markdown + front-matter + thin config, never structured-first.**
  The GM-readable document *is* the deliverable; nobody writes a good cold open
  in YAML. Front-matter takes the machine facts that were being restated in prose,
  which is where the drift lives.
- 2026-09-13 — **A missing adapter never blocks a build.** `generic` returns null
  from `buildActor`; the NPC still gets a journal entry and a cast card, just not
  an Actor. Vanity and Dee Sanction ship on day one.
- 2026-09-13 — **Corkboard's schema is imported, never copied.** `validateBoard`
  runs at *scenario* build time, so a board that would break in Foundry fails the
  build. A pinned `fingerprintPortable` catches schema drift loudly.
- 2026-09-13 — **`sf-` keys are engine-owned; everything else is the GM's.**
  Corkboard permits hand-authored entity keys (`ENTITY_ID`, no colons — hence the
  dash), so this needs no schema change, and it is what makes a non-destructive
  re-sync possible.
- 2026-09-13 — **Validator graded by lifecycle, not per scenario.** `status: draft`
  warns on missing art; `convention-ready` enforces everything. Per-scenario
  opt-outs decay into a permanent exemption list.
- 2026-09-13 — **Strings only where declared.** Clue-to-clue links cannot be
  inferred from prose; no string beats wrong string.

**Gotchas**
- **No Foundry CLI.** Packing writes LevelDB directly via `classic-level`,
  because the CLI splits a scene's `levels` into their own sublevel keys and v14
  synthesises a blank level instead — the background art is lost. The workaround
  must carry its comment forward or somebody tidies it back within a year.
- **Adventure re-import is destructive.** `prepareImport` partitions on
  `collection.has(d._id)` and updates with `{diff: false, recursive: false}`, so
  with deterministic ids a re-import replaces the board page wholesale — every
  card the GM moved or added, gone, no diff, no prompt. This is why re-sync is
  phase 1 and not a nicety.
- **AFTERIMAGE's `docId(key)` is unnamespaced**, so two scenarios in one world
  would collide on `folder:journal-scenario`. Latent only because it is the sole
  module. `docId(moduleId, key)` fixes it; AFTERIMAGE's ids change once.
- A `corkboard.board` page survives with Corkboard **disabled** — Foundry keeps
  the source verbatim (`deepClone`) and the unknown type passes under
  `fallback: !strict`. Enable the module later and the board returns intact.

Related: [[corkboard]], [[afterimage]], [[rpg-skill]], [[continuum-2026]]
