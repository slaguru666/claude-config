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

**Current state** — Parser, validator, journal builder, **packer and adventure
assembly** built and pushed 2026-09-13 (`5cdc26b`, 171 tests). `forge build
scenario.config.mjs` produces an installable module end to end — 9 journal
entries, 55 pack keys, `module.json`, LevelDB packs and readable JSON sources.
The AFTERIMAGE regression passes byte-for-byte. `forge check <dir>` runs 17 rules;
all six Continuum scenarios carry front matter and validate at
`convention-ready`, **37 findings down to 4** — all four missing Clue Trails
(Vain Crown, Silvery Moon, Chopper entirely; Day One act 2), which is scenario
writing, not tooling.

**Validate-before-write is demonstrated, not just designed**: pointing the
builder at Silvery Moon prints `C-04 … nothing written` and leaves no `dist/`
behind at all.

**Not yet built** — handouts, actors, scenes and tables (still hand-authored in
`Continuum2026/foundry/afterimage/content/`, ~1000 lines, the port into
`scenario.config.mjs`), the four Corkboard boards, and the Corkboard phase-1
changes. The live acceptance test — build, import into a scratch world, open it —
is now possible and still owed.

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
- 2026-09-13 — **The scene `levels` trap is guarded by a test, not a comment.**
  `HIERARCHY.scenes` omits `levels` because Foundry v14 cannot reassemble it from
  its own sublevel — it synthesises a blank level and the background art is gone.
  A test asserts the omission, so tidying the packer back to the Foundry CLI
  fails loudly instead of silently shipping scenes with no backgrounds. `stamp`
  guards the same loss by the other route: an unstamped document is migrated as
  legacy content, which also discards `levels`.
- 2026-09-13 — **Journal entries are declared against canonical ids, not heading
  text.** The original builder matched literal headings (`"Plot Summary (GM truth
  — players never see this page)"`) and threw when the document was reworded, so
  rewording the scenario was a build break. The coupling now lives in the alias
  map, where it is one edit and a test.
- 2026-09-13 — **The regression compares links by what they point at, not by id.**
  Ids differ on purpose (namespaced by module), so raw HTML comparison would only
  ever prove that. Each `@UUID` is resolved back to its document key on both
  sides, plus a test asserting no id in the output is UNRESOLVED.
- 2026-09-13 — **Read-aloud overflow becomes bullets the GM voices, never a cut.**
  Three blocks were over the house limit; each kept three spoken sentences and
  handed the rest to bullets, so a word-level diff of all three trims shows one
  word changed and nothing removed. AFTERIMAGE act 3 also gained by it: place,
  then what waits at the rail, then Aris's line on its own.
- 2026-09-13 — **R-01 measures beats, not full stops.** *"I'm Aris. The original.
  I assume you've met the revisions."* is one breath at the table; counting its
  full stops made it worth three and inflated act 3 from 7 to 11. A quoted run
  now collapses to one beat. It excused nothing — all three blocks were still
  over under the fairer count — but the trimmed versions end on dialogue and
  would have fired again without it.
- 2026-09-13 — **Handouts are indexed in two places and both are correct** — a
  front-of-document Handout Index *and* a `### Handouts` table inside the act
  that deals them. The template prescribes both; reading only the first reported
  five of Vain Crown's handouts as undefined when its acts define all five.
- 2026-09-13 — **The final act is exempt from needing a clue trail.** C-04 (no
  trail anywhere) and C-05 (a non-final act without one) exist because Silvery
  Moon and Chopper validated *clean* while missing the thing the case board is
  built from. But the house template prescribes trails for Acts One and Two and
  says nothing about the last, because the last is usually a confrontation —
  AFTERIMAGE's pier, Princes Bride's trial. Requiring one there would report two
  finished scenarios as unfinished. Locked in by a test on both.
- 2026-09-13 — **An unrecognised heading is a gap in the format as often as a
  fault in the scenario.** Day One's "THE SHAPE OF THE DAY" and "Zombie Rules —
  Quick Reference" became two new canonical types — `running-this` (GM
  orientation: how the situation holds and what to do when players push on it)
  and `rules-reference` (looked up mid-session, not read). Aliased *generically*
  and the headings renamed to lead with the general stem, keeping their own
  phrasing as the subtitle. A scenario-specific alias would have been the drift
  the validator exists to catch.
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
