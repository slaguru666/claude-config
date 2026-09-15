---
type: project
status: active
repo: slaguru666/scenario-forge
path: ~/Git/scenario-forge
updated: 2026-09-15
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

**Current state** — Parser, validator, journal builder, packer, adventure
assembly and the **full content port** built and pushed (`6845182`, 222 tests).
`forge build scenario.config.mjs` produces an installable module end to end:
AFTERIMAGE rebuilds with **every document the original carries** — 30 journals
(9 scenario entries + 21 handouts), 13 actors, 6 scenes, 1 table, 170 pack keys,
plus `module.json`, LevelDB packs, readable JSON sources and copied assets.
`forge check <dir>` runs 17 rules; all six Continuum scenarios carry front matter
and validate at `convention-ready`, **37 findings down to 4** — all four missing
Clue Trails (Vain Crown, Silvery Moon, Chopper entirely; Day One act 2), which is
scenario writing, not tooling.

**Validate-before-write is demonstrated, not just designed**: pointing the
builder at Silvery Moon prints `C-04 … nothing written` and leaves no `dist/`
behind at all.

**The live acceptance test passed, twice** (2026-09-13 journals-only, 2026-09-14
full content). Built under the id `afterimage-forge` so the real module was never
overwritten, installed, imported into the scratch world **Forge Acceptance Test**
(blade-runner system): 30 journals, 13 actors, 6 scenes, 1 table, folders filed,
pages GM-only, blockquotes styled, `@UUID` links live, **all 37 module asset URLs
return 200**, and the Parlor 88 background renders on canvas. The second import
over the first updated in place and created nothing — the destructive re-import
behaviour, observed rather than inferred. Both are still on the Mac — delete the
world and `~/FoundryVTT/Data/modules/afterimage-forge` when done.

**The four boards are built and packed** (7aa1814, e730a44). They come from
tables the scenarios already contain: Clue Trail -> case board (all hidden,
`gmNote` carries the fallback), NPC Roster -> cast board, Countdown -> timeline
board, plus a near-empty player board with zones only. All six scenarios build
24 boards, 0 errors, 0 coercions.

They ship as a JournalEntry of `corkboard.board` pages **inside the Adventure**,
so importing the adventure brings the boards and nothing extra has to be
explained to the GM. Opt-in throughout: without `boards: true` a build is what
it was — no Boards folder, no Corkboard dependency. With it, `module.json`
declares `relationships.requires: corkboard`.

**Re-sync shipped** (corkboard 35abe6e). A rebuilt scenario now reaches a board
the table has already used: generated cards take the new words, the GM's own
cards, strings, layout and reveals stay put. The import dialog offers Re-sync or
Replace when both boards are generated, so the destructive path is still there
but is no longer the only one.

**Corkboard phase 1 is complete** — barrel, re-sync and the sheet header
(corkboard 440af78, forge 65684d8). A GM opening a generated board sees
`AFTERIMAGE v3.2.0 — Case board` above the tools; players see nothing.

**Next steps** (spec §12)
- Acceptance test the boards: build AFTERIMAGE, import, open the case board —
  the one thing the spike could not verify
- `readClues` is blind to a clue table inside a set-piece, so Chopper's
  INTERLUDE trail (clues 10-13) never reaches its case board
- Adapters beyond `blade-runner` and `generic`
- Move `~/.claude/skills/rpg/assets/scenario-template.md` into `templates/` and
  have [[rpg-skill]] point at it. One template, not two copies drifting

**Key decisions**
- 2026-09-15 — **Re-sync preserves `hidden` as well as position, and the design
  document was wrong to stop at position.** The case board ships every clue
  hidden and the GM opens them as the table earns them; a re-sync between
  sessions that re-hid eight revealed clues would destroy an evening's play to
  fix a typo — the exact harm the operation exists to prevent. Preservation is
  per-entity, so a clue the rebuild ADDS still arrives hidden as authored.
  Content — title, text, gmNote, style, image, link — still comes from the
  rebuild, so a GM who rewrites a generated card loses that edit. That stays:
  the answer is to fix the scenario.
- 2026-09-15 — **The boards ride inside the Adventure, not a pack of their own,
  and the dependency is opt-in.** A separate pack would be one more thing to
  explain at the table; a page Foundry cannot construct imports as an
  "unavailable document" with no way back, so the page source mirrors
  `journals.mjs` field for field rather than being minted fresh. The Corkboard
  requirement is declared only when boards are actually built — a module that
  ships none must not demand a module to render nothing.
- 2026-09-14 — **A build that ships no assets must fail, not fall back.** The
  content port installed clean and rendered broken: the config declared no
  `assets` directory, so the copy step was skipped, every portrait fell back to
  `mystery-man` and every scene background pointed at a file that did not exist.
  Nothing failed, because each individual fallback was a *designed* one.
  `src/build/assets.mjs` now walks the built documents for module-owned paths
  and fails before any write. The distinction it draws is the point: **absence
  is a choice, a broken path is a bug** — an NPC with no portrait declared is
  still fine (Ottley has none in the original either), but a declared file that
  is not there stops the build. It walks the whole document tree rather than a
  list of known image fields, so a builder that grows a new one is covered
  without anyone remembering.
- 2026-09-14 — **A module carries two descriptions and they are not the same
  copy.** The manifest is read in the module browser; the Adventure's is read in
  the import dialog. Both were empty in the first port, so the import dialog
  showed a blank card. `manifestDescription` is now distinct from `description`.
- 2026-09-14 — **`cfg.moduleId` overrides the front matter.** It had been a dead
  key the builder ignored while `module_id` in the front matter decided
  everything, which is why the acceptance build previously needed a hand-edited
  temp copy of the scenario. A config override is the honest home for a variant
  build id — front matter states what the scenario *is*, the config states how
  *this* build differs — and it makes the side-by-side install safe by
  construction rather than by remembering the gotcha below.
- 2026-09-13 — **A JournalEntry has no `img` field in Foundry v14.** Measured in a
  live world during the acceptance test: the schema is `[_id, name, pages, folder,
  categories, sort, ownership, flags, _stats]`. AFTERIMAGE's original builder set
  a cover on every entry and scenario-forge faithfully reproduced it — both were
  writing a field Foundry silently discards. The cover belongs on the **Adventure**,
  which does have it and shows it in the import dialog.
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
- **Never build the acceptance copy under the real module id.** `~/FoundryVTT/Data/
  modules/afterimage` holds the complete, convention-ready module; a forge build
  installed over it would replace it. Set `moduleId: "afterimage-forge"` in the
  config (no longer a temp copy of the scenario) so the two sit side by side.
- **The installed `afterimage` module is a stale build** — 28 journals and 5
  scenes against the repo's 30 and 6. Compare a forge build against
  `Continuum2026/foundry/afterimage/dist/src`, never against what is installed,
  or the forge build looks like it invented content it did not.
- **Foundry holds the pack LevelDBs open.** Quit it before `--install`; the
  guard refuses while it is running, and `--force` past that corrupts packs.
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
