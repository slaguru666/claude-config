---
name: mapwright-module
description: Mapwright — standalone Foundry v14 battle-map generator; published on GitHub (slaguru666/mapwright)
metadata: 
  node_type: memory
  type: project
  originSessionId: 876e6f57-7721-4a19-83bd-1400e94b8c64
---

`mapwright` — standalone Foundry VTT battle-map generator at `~/FoundryVTT/Data/modules/mapwright/`. Auto-generates good-looking tactical maps with Foundry walls/doors/windows/lighting pre-placed. Fresh rebuild replacing the underwhelming `quick-battlemap-builder` / sprawling `scifi-deckplan-generator`.

**PUBLISHED (2026-06-17, v0.5.0):** GitHub repo `https://github.com/slaguru666/mapwright` (public). Install in Foundry via manifest URL: `https://github.com/slaguru666/mapwright/releases/latest/download/module.json`. Releases via `gh` CLI (auth'd as slaguru666) — GitHub MCP has no release tool, so use gh for releases. Release assets: `module.json` + `mapwright.zip` (clean module files, no dev/). To ship a new version: bump module.json version → zip `module.json module templates styles lang README.md` → `gh release create vX.Y.Z module.json mapwright.zip`. `.gitignore` excludes dev/*.svg|png|jpeg|html.

**Live Foundry is v14.361** (world SLA_Industries, system zero-engine). Can log into the GM session via Playwright (Gamemaster user, no password, localhost:30000) to test live. Module is ENABLED there.

**Core principle:** one geometry model feeds BOTH the picture and the Foundry walls. Pipeline per category: generate layout → wall segments → SVG (preview + scene background PNG) + Foundry walls/doors/lights/notes/tiles.

**Categories (6):** Modern Building, Fantasy Building (BSP, footprint shapes rect/L/T/U/plus + "auto" random, multi-floor 1-4 with stairs/elevator, era-aware door/window art, furniture as LOCKED TILES); Cave/Dungeon (organic CA, themes cave/crypt/sewer); Outdoors (grassland/desert/snow/badlands); Town/Village + City Block (solid rooftop blocks + perimeter walls, dense + colourful + lots of baked scenery: cars/trees/lamps/crosswalks/wells/stalls).

**KEY v14 GOTCHAS (hard-won):**
- Scene background moved to LEVELS: set `scene.updateEmbeddedDocuments("Level",[{_id, background:{src,color}}])` on the default level (`defaultLevel0000`), NOT the deprecated `scene.background`. See `applyBackground()` in scene.mjs.
- FilePicker is `foundry.applications.apps.FilePicker.implementation`; normalise upload paths to relative.
- Tiles use `texture.src` (not `img`); furniture tiles are `locked:true`, generated sprites cached in `mapwright/furniture/`.
- Default scenes: tokenVision:false (flat fully-lit map = matches preview); dynamic lighting opt-in.

**File map:** lib/{rng,building,walls,render-vector,furniture,furniture-layout,organic,dungeon,render-cave,outdoor,render-outdoor,settlement,render-settlement,population,scene}.mjs; app/generator-app.mjs; mapwright.mjs (entry). Pure libs are Node-testable via dev/*.mjs harnesses (render → qlmanage to PNG to eyeball).

**Next ideas:** enterable hero buildings; more biomes; moving-traffic city look; village cobble plaza.
