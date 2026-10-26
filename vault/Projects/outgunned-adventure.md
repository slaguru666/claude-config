---
type: project
status: active
repo: none — not in git
path: ~/FoundryVTT/Data/systems/outgunned-adventure
updated: 2026-10-26
---

# Outgunned Adventure (Foundry system + world)

**What it is** — Our own Foundry VTT v14 system for *Outgunned Adventure*, built
2026-10-26 because the installed `outgunned` world/system was clumsy. Rules as
printed (book PDF/MD in `~/Downloads/Outgunned Adventure - Chapters/`).

**Where it lives** — system `~/FoundryVTT/Data/systems/outgunned-adventure`
(id `outgunned-adventure`, v1.0.0, compat 13–14.361); ready-to-play world
`~/FoundryVTT/Data/worlds/outgunned-adventure` (Frozen Legacy pregens, Travel
Journal, rules + adventure journals, title scene). The old `outgunned` world is
untouched; its users are copied into the new world.

**Current state** — Built and click-tested in a scratch Foundry on port 30001:
creation wizard, sheets, roll dialog + chat card (re-roll / All In / judge),
conditions, Grit boxes, Death Roulette, Spotlight, Director's Chair (phases,
enemy, calls, Run tracker), Heat + Appointments, traps, support sheet.
Not yet played at a table with real players.

**Next steps** — Tim launches the world and runs Frozen Legacy; collect friction.

**Key decisions**
- Dice maths in `module/engine.mjs` (pure, `node tools/test-engine.mjs`): points
  model, Basic 1 / Critical 3 / Extreme 9 / Impossible 27.
- Packs and world are generated: `node tools/build-packs.mjs` then
  `node tools/build-world.mjs` (refuses a world with chat history unless `--force`).
- npm deps installed with `--ignore-scripts` (spawn ELOOP otherwise).
- v14 gotchas: scene background lives on a Level record; AppV2 reserves `state`;
  `_prepareContext` runs before `_preFirstRender`; chat strips inline SVG.

Related: [[custodians-ringbrp]], [[corkboard]]
