---
name: ringbrp-project
description: "RingBRP — a BRP conversion of the 1984 Chaosium Ringworld RPG, now a working Foundry VTT system"
metadata: 
  node_type: memory
  type: project
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-08-07T23:37:53.296Z
---

Started 7 August 2026. Two locations: design docs in `~/RingBRP/design/`, the working game system
in `~/FoundryVTT/Data/systems/ringbrp/`.

## Where it stands
- **Source corpus**: all 9 Ringworld PDFs Docling-extracted to `~/RingBRP/extracted/`.
- **Setting bible**: `~/RingBRP/RINGWORLD_BIBLE.md`.
- **Rules spec**: six versions, v0.6 current. Each reviewed adversarially by Codex; full history in
  `~/RingBRP/design/REVIEW_LOG.md`.
- **Foundry system**: `ringbrp` v0.6.0, verified running in a live Foundry v14 instance with a
  world called `ringbrp-slice`. Four pregens, four NPC statblocks, 49 skills, 20 weapons,
  site/hazard tables and a 7-page GM journal, all in LevelDB compendia.

## Owner's rulings (do not re-litigate)
- Melee Combat is governed by **STR**; Ranged by **DEX or POW** — never summed. Home-world gravity
  **determines** which, with no override: light→Reflex/DEX, heavy→Deliberate/POW, normal→choice.
- **No hit locations.** Final.
- Hit points are `CON + MAS` (the 1984 value), Major Wound `max(9, ceil(HP/3))`. The floor is
  deliberate — without it a light-framed character's dagger risk triples.

## Hard-won lessons
- **Rewards accelerate; they never gate.** Two versions failed because a scenario-critical object
  sat behind a probability gate (the second time at P=1.7%). Anything on the critical path must be
  reachable by some route with probability 1.
- **Derive HP from the weapon damage ladder, not the other way round.** The 1984 damage values are
  calibrated to a ~26-point pool; halving HP collapses the ladder into one-hit kills.
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
