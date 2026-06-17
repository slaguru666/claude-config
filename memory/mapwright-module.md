---
name: mapwright-module
description: Mapwright — new standalone Foundry v13 battle-map generator module being built from scratch
metadata: 
  node_type: memory
  type: project
  originSessionId: 876e6f57-7721-4a19-83bd-1400e94b8c64
---

Building `mapwright`, a standalone Foundry VTT v13 module at `~/FoundryVTT/Data/modules/mapwright/` that auto-generates tactical battle maps with Foundry walls/doors/windows/lighting pre-placed. Fresh rebuild — replaces the underwhelming `quick-battlemap-builder` and the sprawling `scifi-deckplan-generator` (7k lines, 37+ options, programmer-art SVG).

**Decisions made with Tim (2026-06-16):**
- Visual approach: **procedural-vector** (Watabou-style ink look drawn in code), NOT compositing real tile art. Open to bundling a small curated art pack later.
- First milestone: **indoor buildings (modern + fantasy)** done excellently before other categories.
- Population: **system-agnostic** — labelled GM Notes + prop tiles only; never assume a game system/compendium.
- Distribution: self-contained, OK to bundle a curated art pack.

**Core architectural principle:** one geometry model feeds BOTH the SVG picture and the Foundry walls, so visible walls always line up with sight-blocking walls (the thing both old modules got wrong). Pipeline: `building.mjs` (BSP → rooms+region grid) → `walls.mjs` (segments + spanning-tree door connectivity) → `render-vector.mjs` (SVG) + `scene.mjs` (Foundry docs). `lib/*` is pure/Node-testable; validate visuals with `node dev/render-sample.mjs` then `qlmanage` to PNG.

**Live Foundry is v14.361** (not v13) — world SLA_Industries, system zero-engine. Module declares max 14, verified bumped to 14.361. Hardened FilePicker call to use `foundry.applications.apps.FilePicker.implementation` with global fallback (v14 namespacing). Scene-control toolbar button may need v14 tweaks; reliable entry points are `game.mapwright.open()` console + Scenes-tab button.

v0.3 status (draft 3, built this session): expanded buildings per Tim's feedback (rectangular was too plain). NEW: (1) non-rectangular footprints — buildFootprintMask() in building.mjs supports rectangle/L/T/U/plus; BSP splits bbox then clips rooms to mask via region grid, so exterior walls follow the non-rect outline for free. (2) Multi-floor — generateBuildingComplex() makes 1–4 floors sharing ONE footprint (maskSeed constant) with a vertical-circulation column (elevator=modern, stairs=fantasy) forced at the same cell on every floor; createSceneSet() in scene.mjs makes a Folder of linked scenes + up/down GM notes. (3) Era-aware door/window ARTWORK in render-vector.mjs — filled door leaves (planked wood / metal-slab glass), handles, swing arcs; framed mullioned windows. doorFill added to THEMES. (4) furniture.mjs — vector props per room type (bed/desk/bigtable/racks/counter/crates/shelf/toilet/bunk + stairwell/elevator glyph). render-vector now builds floor + hatching from the REGION grid (buildFloorPath) not the footprint rect. All verified visually (L/U/plus shapes, furniture, era doors, multi-floor staircase) + multi-floor consistency test (identical mask + aligned circ across floors). All JS syntax-checked. STILL not tested inside running Foundry (v14.361). Earlier engines unchanged: caves (organic.mjs), outdoor (outdoor.mjs). Next: prop/furniture as interactive Tiles, built-dungeon rooms+corridors style, water/elevation in caves, UVTT export.

Reference module to study: **Dungeon Draw** (mcglincy) — themed bg + auto-walls from one geometry. Consider UVTT export for ecosystem interop.
