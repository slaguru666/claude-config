---
name: vanity-foundry-install
description: "VANITY on Foundry — Mac data path differs from the Linux one in CLAUDE.md, and foundry/dist/*.zip in VRPG is stale; install from the git tree"
metadata: 
  node_type: memory
  type: project
  originSessionId: c4d6262b-e105-4e05-87bf-f2f891e7df82
  modified: 2026-08-04T21:29:22.480Z
---

VANITY runs on Foundry VTT as a **system** (`vanity`), not a world. Two repos carry it and
`VRPG/sync.sh` publishes one to the other, so they stay in lockstep at the same version:

- **`slaguru666/VRPG`** (private) — rules drafts, rulebook, art, plus `foundry/vanity/`
  (the system), `foundry/worlds/the-vain-crown/` (the ready-made world) and
  `foundry/vanity-stage/` (generated battlemap PNGs the scenes point at).
- **`slaguru666/Vanity`** (public) — the published runtime system only, installable by manifest:
  `https://raw.githubusercontent.com/slaguru666/Vanity/main/system.json`

Two traps, both hit on 2026-08-04 installing v0.10.3 on the MacBook Air:

1. **`foundry/dist/vanity.zip` and `vrpg-foundry-full.zip` are stale.** `INSTALL-REMOTE.md`
   describes them as v0.9.0 and the zip really does contain v0.9.0, while the git tree was at
   v0.10.3. The zips are not rebuilt on release — **install from the git tree, not `dist/`**,
   whenever "latest" matters.

2. **The Mac data path is not the one in CLAUDE.md.** That file records
   `~/FoundryVTT/Data/...`, which is the Linux/MINI-S layout. On this Mac Foundry uses
   `~/Library/Application Support/FoundryVTT/Data/` (confirmed via `Config/options.json`
   → `dataPath`). `~/FoundryVTT` does not exist here.

Three things must land, and the world alone is not enough:

    Data/systems/vanity/          the system
    Data/worlds/the-vain-crown/   the world
    Data/vanity-stage/            battlemap PNGs

Scene backgrounds are stored as paths **relative to `Data/`** (e.g.
`vanity-stage/the-salt-throat-1783978801989.png`), so `vanity-stage/` must sit at the `Data/`
root or every map renders blank.

**Why:** the zips look like the official artefact and the CLAUDE.md path looks authoritative;
both quietly give you a stale or broken install.

**How to apply:** clone VRPG, `rsync` those three directories into the Mac data dir, restart
Foundry. Verify by reading the LevelDB with the app's bundled `classic-level` — `grep`/`strings`
cannot see inside, values are Snappy-compressed. Always read from a **copy**: opening a pack
read-write compacts it and dirties the working tree.

## Map/scene modules on this Mac (2026-08-04)

`mapwright` v0.5.0 installed from its GitHub release — `compatibility.maximum: "14"`, so it runs
on Foundry 14.365. It is the live map generator; `quick-battlemap-builder` and
`scifi-deckplan-generator` are its superseded predecessors.

`quick-battlemap-builder` v0.3.0 was also installed on request, but **it cannot work on v14 as
shipped**, for two independent reasons:

1. `compatibility.maximum: "13"` — Foundry 14 refuses to enable it outright.
2. Even if that is bumped, `quick-battlemap-builder.mjs:395` does
   `sceneData.background = { src }`, the v13 pattern. In v14 the background moved to the scene's
   default **Level**, so generated scenes come out **blank**. The real fix is to mirror
   mapwright's `applyBackground()` (`module/lib/scene.mjs:107`,
   `scene.updateEmbeddedDocuments("Level", [{_id, background:{src,color}}])`).

Its `FilePicker` use is already v14-safe (line 1424 falls back through
`foundry.applications?.apps?.FilePicker?.implementation`), so that is *not* a blocker — only the
background write and the manifest ceiling are.

Related: [[claude-config-sync-gotchas]], [[tims-rpg-games]].
