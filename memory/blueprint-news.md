---
name: blueprint-news
description: Engine-agnostic SLA BPN briefing generator at ~/blueprint-news/ (component + standalone app)
metadata: 
  node_type: memory
  type: project
  originSessionId: 5042e85b-5232-4f59-bf1d-92d635c764de
---

"Blueprint News" — a new **engine-agnostic** SLA Industries BPN (Blue Print News)
mission-briefing generator at `~/blueprint-news/`. Rebuild of the earlier
Foundry-bound experiments with every engine call stripped out.

Shape: a framework-free ES-module **component** + a standalone web **app** built on it.
- `core/` — `generateBPN({seed,colourKey,frameId,squadSize,overrides})`, deterministic; `data/` colours, frames, tables.
- `art/bpn-art.js` — seeded procedural SVG (`crestSVG`, `bannerSVG`): flat stencil/propaganda SLA style, never photorealistic. Seed drives the art.
- `render/` — `briefHTML()` (Player Brief) + `dossierHTML()` (GM Dossier), scoped under `.bpn`; responsive + print CSS.
- `assets/fonts/` — bundled local Josefin Sans + Roboto Mono + Modesto Condensed.
- `app/` + `index.html` — generator UI: Player/GM/Both, library (localStorage), Print, Export HTML.

Two **separate surfaces** per briefing: Player Brief (official dispatch) vs GM Dossier
(twist, withheld fact, true threat read, levers, dice state).

NPC/monster generation is a **separate future module** — each briefing exposes
`bpn.npcSeam {contactArchetype, threatArchetype, threatRole}` as the hand-off seam.

Per-band art: `art/bpn-art.js` `SCENES` map drives distinct foreground motifs
(tunnel/transit/wall/cordon/gantry/stage/canal/tower/vault/exec) + atmosphere/lighting;
`portraitSVG()` gives a halftone non-photorealistic contact ident in the Player Brief.

Published PUBLIC at https://github.com/slaguru666/blueprint-news (default branch `master`).
GitHub **MCP is not authenticated** here — use the `gh` CLI (logged in as slaguru666) for pushes.

**Zero Engine variant**: separate module **Blueprint News 0 Engine** (id `sla-blueprint-news-zero`)
at `~/FoundryVTT/Data/modules/sla-blueprint-news-zero/`, repo https://github.com/slaguru666/sla-blueprint-news-zero (v0.5.0).
Superset of the base module that, in a `zero-engine` world, also spawns real Zero Engine `npc`
actors on Create — a threat group (leader + mooks: gangs/Carrien/corpsec/Stormer/black-ops) + cast —
with attributes, HP, armour, damage, threat and embedded weapons, replicating the system's own NPC
Creator (`SLA_NPC_TYPES`/`_slaWeaponData` in systems/zero-engine). Logic in `module/zero-adapter.mjs`.
De-collided (global `game.slaBlueprintNewsZero`) so it coexists with the base module. Original
module backed up to `sla-blueprint-news-backup-20260617-185229.tar.gz`. Not load-tested in Foundry yet.

**Foundry module** (the installable deliverable): `sla-blueprint-news` at
`~/FoundryVTT/Data/modules/sla-blueprint-news/`, ApplicationV2 generator (idiom from
mapwright), vendors the component under `module/vendor/`, writes one JournalEntry with a
player **Mission Brief** page (Observer) + GM-only **Dossier** page (None). Uses render
`artMode:"img"` so Foundry doesn't strip inline SVG. Published at
https://github.com/slaguru666/sla-blueprint-news (release v0.1.0); remote install manifest:
`https://raw.githubusercontent.com/slaguru666/sla-blueprint-news/main/module.json`.
Not yet load-tested in a running Foundry world.

Source aesthetic/palette/fonts come from `~/FoundryVTT/Data/systems/sla-industries-brp`.
Run with any static server (ES modules need HTTP); `.claude/launch.json` serves it on :8778.
Related: [[mapwright-module]].
