---
name: ringbrp-project
description: "THE CUSTODIANS (dir: ringbrp) — a BRP Foundry system grown out of the 1984 Ringworld RPG; rules.mjs is the sole rule authority and has superseded the old design-doc rulings"
metadata: 
  node_type: memory
  type: project
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-09-23T02:00:00.000Z
---

Started 7 August 2026. **Two repositories, and the distinction matters:**

- `~/FoundryVTT/Data/systems/ringbrp/` → `slaguru666/RingBRP` — the playable Foundry system.
  `rules.mjs` there is the ONLY rule authority. Scenarios live inside it at `docs/scenarios/`
  (`LAST_ADMISSION`, `OPEN_DAY`, `THROUGH_TRAIN`), which is why searching Gitea for a scenario
  repo finds nothing. `docs/GM_SCREEN.md` is the table-facing sheet, every figure verified by
  running the functions. Guards run under **bun**: `npm test` → `bun run check` → 25 guards (Sep 2026).
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

## Making NPCs, threats and monsters (23 Sep 2026)

- **Generated NPCs draw their posting's kit.** `drawKitFor(role, tier, {classify})` in
  `postings.mjs` decides what is issued; `generateNPC` resolves the keys against the packs.
  Before this it read `R.core`/`R.support` only, so the dialog's DRAWS FROM STORES card
  promised nine items and the actor got a utility knife.
- **A weapon names the skill that fires it** (`skillFamilyId`/`skillSpecialisationId`), so
  there is no weapon↔skill pairing table and nothing can be issued that its holder cannot
  use. The same idea put `plans` on the ten natural attacks — which body plans can make
  them — because anatomy records that a creature has a head, not that the head has horns.
- **Kit keys have drifted from their names.** `climbing_kit` is "Breaching charges",
  `prybar` is "Entry bar". Classify by catalogue membership, never by reading a key.
- **The forge**: `forge.mjs` at the ROOT (pure, like `rules.mjs`/`postings.mjs`),
  `tools/forge.mjs` as the CLI (`new`/`explain`/`measure`/`list`), and a third
  Actors-sidebar button calling `generateCreature`. One derivation so the CLI and the
  panel cannot diverge — but they feed it from *different* catalogues, so `check-forge`
  reads the built pack and requires both to forge the same creature.
- **Measurement**: `tools/npc-cohort.mjs` builds a generated NPC as a simulator spec in
  the old and new configurations and measures both. `measure()` returns `wipeRate` as a
  **fraction** — multiply by 100, as `check-lethality` does.

## Hard-won lessons
- **Rewards accelerate; they never gate.** Two versions failed because a scenario-critical object
  sat behind a probability gate (the second time at P=1.7%). Anything on the critical path must be
  reachable by some route with probability 1.
- **Derive HP from the weapon damage ladder, not the other way round.** The 1984 damage values are
  calibrated to a ~26-point pool; halving HP collapses the ladder into one-hit kills.
- **A long `--no` list stalls a Midjourney job silently** — ten or more terms never return
  a grid, which looks exactly like a moderation refusal. `promptFor` throws above six now.
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

## Running the guards and a local Foundry (11 Oct 2026)
- **`bun run check`, never `npm run check`.** `npm run <script>` cannot spawn in the
  desktop-app sandbox at all — see [[infra-npm-sandbox-exit-194]].
- **Shut the world before running the guards.** A launched world holds a write lock on
  every LevelDB pack, so `check-packs` dies with `LEVEL_DATABASE_NOT_OPEN`, which reads
  nothing like "Foundry has the file".
- **Launching a world compacts all 21 packs**, so `git status` afterwards shows every one
  of them churned with no content change. Do not pick through it — `bun run build` is
  deterministic and puts the tree back to just the packs whose content really changed.
- Local Foundry is **14.361** on port 30000; the ringbrp world is `ringbrp-slice` ("The
  Ilfracombe Crossing"), Gamemaster user, no password. Launch it with
  `POST /setup {"action":"launchWorld","world":"ringbrp-slice"}` — the key is `world`,
  not `id` or `packageId` — and shut it with `game.shutDown()` from the page.
- **`tools/foundry-double.mjs`** is enough of a Foundry to import `ringbrp.mjs` into node
  with a scripted dice queue; `tools/check-panic-live.mjs` runs 27 scenarios through it.
  Use it for anything check-behaviour can only grep for. It cannot prove template
  rendering or that Foundry's update pipeline accepts a field — a live world can, and
  did: an unknown `system.*` path is dropped silently.

