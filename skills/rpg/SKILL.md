---
name: rpg
description: >-
  Tim's tabletop RPG scenario-writing system — house structure, GM-readable
  writing style, pregen design, playtesting protocol, production pipeline
  (handouts, art, GM console), and memory/repo integration. Use this skill
  whenever the work touches tabletop RPG scenarios or adventures in ANY way:
  writing or revising a scenario, one-shot, con game, adventure, module,
  campaign, session, or BPN; designing pregens, NPCs, clues, handouts, chases,
  or set-pieces; playtesting; preparing convention slots (Continuum,
  Contingency, Airecon, Convulsion, ChaosiumCon); or working with systems like
  Blade Runner, Call of Cthulhu, SLA Industries, Mothership, Traveller,
  Pendragon, Daggerheart, Shadowdark, Stormbringer, RingWorld, BRP, Delta
  Green. Trigger even if the user doesn't say "scenario" — "prep my Friday
  slot", "new adventure for X", "fix the pregens", "make handouts" all count.
---

# RPG Scenario Writing

Tim writes tabletop RPG scenarios — mostly 4-hour convention one-shots, sometimes
longer campaign material — and runs them as GM. This skill is the house system:
structure, style, production pipeline, and the memory loop that keeps it all alive
across machines and sessions.

## The prime directive: write for the GM at the table

A scenario is a performance document, not a novel. The GM reads it in 30-second
glances while four people wait. Every formatting decision serves that:

- **Scannable over literary.** Bullets, tables, bold keywords. Prose only where it
  earns its place (read-aloud text, plot summary, atmosphere).
- **Information in the order the GM needs it**, not the order the story happens.
- **Read-aloud text in `>` blockquotes**, ≤3 sentences by default (players
  disengage after two; only the cold open may run to 4–6), always labelled
  "read aloud or paraphrase". Longer material becomes bullets the GM voices.
- **Mechanics inline, bracketed:** `[BR: Observation — spots the torn hem]`.
  Never send the GM to another page for a roll.
- **Every NPC gets a one-line essence** (who they are + what they want) before
  any detail, and appears again in the end-of-document **NPC Roster quick sheet**.
- **State the failure case.** Every clue, scene, and set-piece says what happens
  if players miss it, skip it, or break it.

## Workflow

### 1. Orient (start of any RPG task)

- Query Graphiti (`search_memory_facts`) for the scenario/convention/system at hand.
- Find the working directory. Convention material lives under
  `~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/<Event Year>/...`
  and is mirrored to a private GitHub repo per event (e.g. `slaguru666/Continuum2026`).
- Ask which **scenario type** this is only if it isn't obvious:
  - **Convention one-shot** (default) → read `references/convention-one-shot.md`
  - **Campaign / multi-session** → read `references/campaign.md`
- For craft questions (structure, clues, pacing, mystery design) read
  `references/craft.md`. Before writing or revising anything, skim
  `references/lessons.md` — it is the accumulated playtest wisdom.

### 2. Build

Order of work for a new scenario:

1. **Concept + Design intent** — 3–5 numbered statements of what this scenario
   is and deliberately is not. Include an elevator pitch line (the tagline under
   the title) and content warnings.
2. **Plot Summary (GM truth)** — the full hidden truth, then a **timeline** of
   events before play begins. Write this before any scenes: scenes are windows
   onto a situation that already exists.
3. **Structure pass** — acts, timing table with GM checkpoints, countdown clock
   of what antagonists do on schedule.
4. **Scenes, NPCs, clue trails** — per act, using `assets/scenario-template.md`.
5. **Pregens** — read `references/pregens.md`. Wire each PC into the case.
6. **Production** — handouts, art, GM console, print: `references/production.md`.
7. **Playtest** — read `references/playtest.md`. A scenario is not
   "convention-ready" until it has survived desk playtests and the fix list is
   applied and versioned.

### 3. Close the loop (end of any RPG session)

This skill is **live** — it must get smarter every time it is used:

- **Graphiti:** `add_memory` with decisions made, scenario state, and anything
  learned (structure fixes, ruling patterns, player-behaviour discoveries).
- **Repo:** commit and push scenario work to its event repo.
- **Skill self-update:** if the session produced a transferable lesson (not
  scenario-specific detail), append it to `references/lessons.md` with a date
  and one-line context, then sync the skill across machines:
  `cd ~/Git/claude-config && ./sync.sh "rpg skill: <what changed>"`.
  Scenario-specific facts go to Graphiti, *transferable craft* goes to lessons.md
  — that distinction keeps the skill lean.

## House conventions (all scenario types)

- **Files are Markdown**, one scenario per file, self-contained (a GM with only
  that file can run the game). HTML only for print artifacts (character sheets,
  handout packs, GM console).
- **Folder shape per scenario:** `scenarios/` `characters/` `handouts/`
  `reference/` `playtest/` `gm-utility/` `print/` + `README.md` index with
  status line (version, playtest count, remaining prep).
- **Versioning:** v1 draft → playtest → v2, v2.1... Status becomes
  "convention-ready" only after a full-session playtest lands inside the time
  budget. README tracks version + what remains.
- **Mechanic tags:** `[SYSTEM: Skill — effect]` e.g. `[CoC: Spot Hidden — ...]`,
  `[BR: Manipulation — ...]`. Include a 3–4 line system crash-course in the
  Master Rules block so a stand-in GM could run it.
- **Art:** ink sketch / pencil illustration, hand-drawn feel, never
  photorealistic. Asset IDs `[Slot]-ART-[##]`, handouts `[Slot]-H[act]-[letter]`.
  Generate via `mj-gen "<prompt>"` (Midjourney bridge). Each scenario defines
  its own art direction line on top of the base style.
- **Licence footer** on READMEs: private convention play materials, not for sale.

## Reference files

| File | Read when |
|---|---|
| `references/convention-one-shot.md` | Building/revising a 4-hour slot scenario (the default) |
| `references/campaign.md` | Multi-session or open-ended material |
| `references/craft.md` | Structure, clue, pacing, mystery design decisions |
| `references/pregens.md` | Creating or auditing pre-generated characters |
| `references/playtest.md` | Running desk playtests, writing fix lists |
| `references/production.md` | Handouts, art, GM console, print, repo layout |
| `references/lessons.md` | Always skim before writing; append new lessons |
| `assets/scenario-template.md` | Starting a new scenario document |
