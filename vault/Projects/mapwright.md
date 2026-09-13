---
type: project
status: complete
repo: slaguru666/mapwright
path: ~/FoundryVTT/Data/modules/mapwright
updated: 2026-09-13
---

# Mapwright

**What it is** — A standalone Foundry VTT battle-map generator. Auto-generates
tactical maps with walls, doors, windows and lighting already placed. A fresh
rebuild replacing the underwhelming `quick-battlemap-builder` and the sprawling
`scifi-deckplan-generator`.

**Where it lives** — `~/FoundryVTT/Data/modules/mapwright/`, public repo
`slaguru666/mapwright`. Foundry install manifest:
`https://github.com/slaguru666/mapwright/releases/latest/download/module.json`.

**Current state** — Published v0.5.0 (2026-06-17), enabled in the live Foundry v14
world. Six categories: Modern Building, Fantasy Building (BSP, footprint shapes,
1–4 floors), Cave/Dungeon (organic CA), Outdoors, Town/Village, City Block.

**Next steps** (ideas, not commitments) — enterable hero buildings; more biomes;
moving-traffic city look; village cobble plaza.

**Key decisions**
- **One geometry model feeds both the picture and the Foundry walls.** Pipeline per
  category: layout → wall segments → SVG + walls/doors/lights/notes/tiles.
- Default scenes ship `tokenVision:false` so the flat fully-lit map matches the
  preview; dynamic lighting is opt-in.

**Gotchas (v14, hard-won)**
- Scene background moved to **Levels**: update the `Level` embedded document on
  `defaultLevel0000`, not the deprecated `scene.background`. See `applyBackground()`.
- FilePicker is `foundry.applications.apps.FilePicker.implementation`.
- Tiles use `texture.src`, not `img`. Furniture tiles are `locked:true`.
- GitHub MCP has no release tool — use the `gh` CLI for releases.

Related: [[loom]] (the map generator is a port of this), [[blueprint-news]]
