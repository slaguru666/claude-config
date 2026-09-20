---
type: project
status: active
repo: github.com/slaguru666/ordinance (public)
path: ~/Git/ordnance
updated: 2026-09-19
---

# Ordnance

**What it is** — A standalone, browser-based seeded battle-map generator for
tabletop play: dungeons, buildings, starship decks and wargames tables. Built
overnight 2026-09-17/18 while Tim slept, from a one-line brief.

**Where it lives** — `~/Git/ordnance` on `fedora` → GitHub `slaguru666/ordinance` (public, repo name spelt *ordinance*).
Published as an Artifact: https://claude.ai/artifact/PPqRpQQ4Eg3ZqRJ7y16vPn

**Current state** — v12: 10 palettes, battlefield symmetry, rivers and roads,
courtyard and towered buildings, floors that stack, buildings planned from
architectural rules rather than subdivision, five generators (dungeon, building,
starship, station, battlefield) with ship circulation topologies and four station
forms, and a keyed room-detail layer across all four. 15059 invariant assertions
passing (`node test.mjs`), plus `playtest*.mjs` / `shot-hand.mjs`, which drive the
real UI in Playwright as a GM would. Deep-linkable: every parameter rides in the
URL. Exports PNG, SVG, geometry JSON, a plain-text key and Foundry wall documents
via the `downloads` capability, falling back to clipboard outside claude.ai.

**VTT exports (2026-09-19, commits 378a6a8 + 6be38a7, Artifact v14; verified in a live v14 world)** — "Virtual tabletop" panel: map image
(100 px/sq, no margin), Foundry v14 Scene JSON, Journal JSON, importer macro (links
pins to pages), Universal VTT `.dd2vtt`. All in `js/export.js`; `playtest-vtt.mjs`
overlays exported walls on the exported image.

**New-GM features (2026-09-19, baa2c77…2bcc4aa, Artifact v23)** — carved rooms
keyed; editable key (read-aloud, GM note → Foundry secret block); players' copy;
keep a room and reroll; stocking by party level (`js/gen/stock.js`); projects of
linked maps with teleports (`js/project.js`); presets + guide (`js/presets.js`);
stamps; tiled 1-inch print (`js/print.js`); hex grids (`js/hex.js`).
`playtest-gm.mjs` drives all ten as a GM.

**Next steps**
- Decide whether this becomes a repo (Gitea + GitHub) or stays an Artifact
- `.dd2vtt` has no hex grid type — a hex sheet imports there as squares

**Key decisions**
- **Hexes are laid exactly as Foundry lays them**: one square across the flats, odd
  columns/rows offset (HEXODDQ flat, HEXODDR pointy), padding 0. So `grid.size` is
  unchanged and only `grid.type` differs; walls and regions stay on squares.
- **A VTT image has no margin and its own px.** The sheet's margin, title block and
  zoom×dpr are why the old wall export could never align. Foundry scenes export with
  `padding: 0` — canvas coords include padding. Journal links need the macro: Import
  Data discards the imported entry's `_id`.
- **Import Data runs Foundry's migrations unless `_stats.coreVersion` says v14.**
  Unstamped, `migrateLevels` (<14.353) rebuilds levels from the legacy `background`
  and the image vanishes. The macro's `Scene.create` never hit it — only a live
  import showed it. dd2vtt walls must be polylines: dd-import adds a joining wall
  at every line junction.
- **Room detail is contents, not atmosphere** (`js/gen/detail.js`), namespaced by map
  kind. A flat table keyed by room name loses entries silently to duplicate keys —
  that is how dungeons got station job boards. Dealt without replacement; when the
  pools run out a room gets nothing rather than a repeat.
- **A generator's character is its circulation, not its outline.** Ships looked
  identical because they all had one axial spine; the hull shapes were already
  varied. Same insight as buildings. `js/gen/plan.js` now holds the shared planner.
- **Never rasterise a rotated rectangle.** Sampling a rotated rect along its axis
  gives a corner-connected staircase. `thickSegment` measures distance to the segment
  with a radius of at least 0.75 so diagonals stay edge-connected. This bit twice —
  the battlefield road and the station arms — before it was written down.
- **Buildings are planned circulation-first, not subdivided.** BSP has no hall, so
  every room opens into its neighbour — that is precisely why the old plans looked
  unreal. Spine plus branches, then rooms in what is left. Numbers from practice, in
  `js/gen/building.js`: circulation 11–20% of floor plate, daylight depth 4 squares,
  room proportion 1.2:1–1.5:1.
- **Rules choose, a guarantee pass enforces.** Architectural door placement left
  sealed pairs of rooms; reachability is forced afterwards. Same shape as the
  battlefield symmetry rule — preference and correctness are separate passes.
- **A symmetrical table places every piece as a pair, and neither is committed
  unless both fit.** A piece that fits on one side only is exactly the unfairness
  symmetry exists to remove. The mirror that is fair depends on where the armies
  stand, so it is derived from the deployment zones, not fixed.
- **A river on a table is not a pool in a dungeon.** Water is impassable in the
  model, which correctly walls a dungeon pool; walling a stream would stop movement
  on the sheet *and in Foundry*. `finish({openWater:true})` threads through to
  `deriveWalls` for fields only.
- **A building's shell is drawn from its own RNG stream, ignorant of the storey.**
  Footprint, towers, BSP cut lines and the stair position come from the shell
  stream; names, room merges, doors, windows and furniture from the storey stream.
  That is what makes floors stack: load-bearing walls line up, rooms differ.
- **Pen & ink hatches the outline, not the sheet.** A flat 45° screen over the paper
  is a texture; hatching combed outward from each wall, thinning with distance, is
  how the plan is actually drawn by hand. A battlefield has no rock to comb, so its
  terrain is shaded instead.
- **One geometry model feeds the drawing, the exports and the wall data** — carried
  over from [[mapwright]], which is the same decision that worked there. Walls are
  *derived* from cell adjacency rather than placed, so the picture cannot disagree
  with the Foundry import.
- **Not parchment.** A drafting-office survey sheet with a real title block carrying
  the seed, so a printed sheet can be regenerated exactly. Cream-and-serif fantasy
  map is the most over-generated look there is.
- Named Ordnance, deliberately not "mapwright 2" — Ordnance Survey plus artillery,
  and a distinct name keeps the two separable in this vault.
- Invariants are tested in node against the pure generators, not by looking at
  pictures: connectivity, determinism, reachability, hull symmetry, sight lines.

**Organic dungeons and borrowed features (v4)** — Room shapes (rect / mixed /
organic) with oval, rounded, octagon, cross and hewn masks; walls derive from the
cells, so an oval chamber gets an oval wall run. Rough-hewn wall drawing, Watabou's
look, with the wander hashed from the coordinate so canvas and SVG agree exactly.
Corridor styles straight / errant / labyrinth, false passages kept / trimmed /
removed, stairway count, and a hex grid overlay — all four borrowed from donjon,
which offers exactly these. Chamber names now use the once/many split the buildings
and ships already had.

**The toolbar moved above the map (v4)** — Tim could not see how the drawing worked,
and measurement showed why: the tools sat 640–790px down a *scrolling* rail under
three other sections, and were cut off entirely on a 720px laptop. They now live in a
bar directly above the sheet with an always-visible hint line saying what the current
tool does, single-key shortcuts (M/P/E/R/W/D) and inline options.

**Drawing (v3)** — Six tools: measure, pen, eraser, room, wall, door. Edits are an
ordered op list replayed onto a freshly generated map, so one undo stack covers ink
and structure, a dragged wall run is one gesture, and a drawing survives a reseed.
Ink carries per-point pen pressure and travels in the PNG, SVG and geometry exports.
Hand-drawn structure is *real* geometry: carve a room and its walls derive exactly as
a generated room's do, so it exports to Foundry identically. Edits are keyed to the
map they were drawn on and kept in `localStorage`, so returning to a seed brings the
drawing back.

**Play-test findings, all fixed in v2** (three driven sessions: D&D prep, a 40k
table, a mid-session boarding action)
- Cave keys described doorframes and barred doors in caves with no doors; details
  were drawn with replacement so two rooms read identically. Pools are now split by
  built/natural and dealt without replacement.
- Every deck of a ship was a complete ship — a four-deck vessel had four bridges and
  four jump drives. Decks now have roles: deck 1 commands, the lowest runs the
  drives, the rest are accommodation, and a companionway joins them at one station.
- Objectives were given as corner coordinates; a wargamer needs distance from each
  deployment zone. The key now states both, plus zone depth and a grouped terrain
  set-up list ("6 × Ruins — blocks line of sight").
- The key now states exits per room, including locked and secret, and can be taken
  as plain text for session notes. Door symbols have their own legend.

**Gotchas**
- Cellular-automata caves are **never** connected on their own; `ensureConnected`
  joins regions rather than discarding them.
- An inline canvas `style.height` beats the stylesheet, so `max-width:100%` squashes
  the map instead of scaling it. Set height to `auto` and let the ratio do it.
- Banning terrain inside deployment zones makes diagonal tables impossible to block:
  the sight corridor runs through the zones themselves. Published layouts put ruins
  in the zones.
- The companionway's position must come from the hull alone. Deriving it from each
  deck's own valve layout put it at a different station on deck 3 than deck 2, which
  defeats the only thing it is for.
- `canvas.toBlob`'s callback waits for the next frame, which headless Chromium does
  not produce unattended — the PNG export looks dead under test and is fine in a real
  browser. Do not "fix" it.

Related: [[mapwright]] (the Foundry module this borrows its architecture from),
[[loom]], [[corkboard]]
