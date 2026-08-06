---
name: vanity-forge-exists
description: "VANITY's vanity.mjs already ships a full generator suite (stage/map, encounter, hoard, monster, NPC, hero, adventure) — check it before building any VANITY generator"
metadata: 
  node_type: memory
  type: project
  originSessionId: c4d6262b-e105-4e05-87bf-f2f891e7df82
  modified: 2026-08-04T21:53:20.458Z
---

Before writing **any** generator for VANITY, read `systems/vanity/vanity.mjs`. It already
contains "the Forge", and it is far bigger than the compendia suggest:

| Function | Line | Does |
|---|---|---|
| `forgeStage()` | 2714 | **Map + scene generator.** Types `barrow · cave · fen · village · forest`, sizes; layout → `stageWalls` → `stageSVG` → raster/upload → `Scene.create`; optional `populate` + `heat` |
| `forgeEncounter()` | 2875 | Monster pool by type, heat composition (`skirmish · fight · battle · nightmare` via `HEAT_BUILDS`), situation/terrain/complication tables, **2d6 Reaction mood roll**, ambush, auto-hoard, GM-whispered card |
| `forgeHoard()` | 1958 | Hoard tiers `pocket · cache · chest · vault · kingly`, relic chance in richer tiers |
| `forgeMonster` / `forgeFace` / `forgeHero` | 1796 / 1866 / 1633 | Actor generation |
| `forgeAdventure()` | 3113 | Chains stage + encounter + hoard |
| `carouse()` / `stageVainCrown()` | 2916 / 3259 | §27 carousing; builds the shipped adventure |

The `vanity-stage/*.png` files shipped with The Vain Crown were produced by `forgeStage` — that
is what the directory name means. It is VANITY-native and already correct on Foundry v14.

Two constraints on reusing it:

- Everything uses `Math.random` (`vanity.mjs:1548`) and creates Foundry documents directly, so
  it is **not seed-reproducible** and not callable outside Foundry. Any tool wanting determinism
  must either extract the data tables or make the Forge injectable.
- None of it is a public API — no `game.vanity.forge*` surface — so an external module would be
  reaching into system internals.

**Why:** it is invisible from the compendium list, and the obvious move (build a generator) means
writing a fourth duplicate of code that already works. This finding shrank the DELVE design from
"build generators" to "sequence the existing ones" — see [[vanity-delve-design]].

**How to apply:** grep `vanity.mjs` for `function forge` first. Related:
[[vanity-foundry-install]].
