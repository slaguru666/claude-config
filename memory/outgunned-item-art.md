---
name: outgunned-item-art
description: Outgunned Adventure Foundry system has per-item hand-drawn ink badge art (187 items); how it is built and re-rolled
metadata:
  node_type: memory
  type: project
  originSessionId: 13053b03-e703-4e40-9ec4-dcbacfbddd70
  modified: 2026-10-28T00:37:12.005Z
---

Done 2026-10-28. System `~/FoundryVTT/Data/systems/outgunned-adventure` (not a git repo) has 187 badges in `assets/art/<type>-<key>.webp` (":" → "-").

- Subjects: `tools/data/item-art.tsv` (id<TAB>subject). `tools/build-packs.mjs` `artFor()` uses the webp when present, else the type icon; rebuild needs the world closed.
- Raw MJ PNGs: `~/MidjourneyInbox/outgunned-art/raw/`. Pipeline: mj-gen with a pen-and-ink 1930s pulp stamp style, then duotone + roundel matching `assets/icons/*.svg` (rim #5a3a22, cream #e9dcc0, ink #2a1a10, art at 74% inside r41). Scripts: `tools/mj-batch.sh <tsv> <rawdir>` (skips existing PNGs; delete one to re-roll) and `uvx --with pillow python -I tools/badge.py <rawdir> assets/art [ids]`.
- World docs were patched in place (items + actors' embedded items, by `flags.outgunned-adventure.key`). New imports pick up art from the packs.
- Weakest picks if revisiting: weapon-boomerang, enemyFeat-run-trap.

Related: [[midjourney_bridge]]
