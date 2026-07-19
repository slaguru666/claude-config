---
name: afterimage-scenario
description: AFTERIMAGE — new 4-player Blade Runner scenario for Contingency 2026 Wed Slot 3; repo slaguru666/Contingency26 (private); playtest fixes pending review
metadata: 
  node_type: memory
  type: project
  originSessionId: 445b61b6-6e68-4f8e-8caa-28bf213400e9
---

AFTERIMAGE is the new Blade Runner RPG scenario for Contingency 2026, Wednesday 28 Jan 2026, Slot 3 (4 players, replaces the 6-player Shattered Nexus plan). Chamber-noir: memory designer Elias Kade dead; three replicant copies of his estranged daughter Aris; the real Aris may or may not have killed him — ambiguity is by design and must not be resolved by dice. Foot chase in Act Two (night market); duplicated key-memory monologue handout (print W3-H02-A twice) is the core reveal.

Locations: private GitHub repo `slaguru666/Contingency26`; local copy in the con folder under `.../Slot 3 Evening Blade Runner/AFTERIMAGE/`.

Also in the repo: **REP-DETECT GM Console** (`gm-utility/index.html`) — Tim's touch-screen Blade Runner GM app; offline single-file HTML, localStorage per module + JSON export, scenario modules via `BRGM.registerModule()` in `gm-utility/modules/` (AFTERIMAGE included). To add a scenario: new module JS + a script tag in index.html.

Status (2026-07-18, v2.2): **convention-ready** — three desk playtests (GM chair, Act Two stress, player chair), three endings, all inside 3:30; art complete; only physical prep remains (print sheets/handouts — monologue card ×2 — and Tim's read-through). Earlier v2.1 detail: Fixes 1–5 applied (field-scan `IDENT CONFLICT` spoof, idle players voice chase obstacles capped at 30s cameos, monologue recital staging, Esper facial search sanctioned, dawn-pressure throttle + partial-wipe ending). Act Two stress re-run done (split path + no-split/chase-escape variant); patches 10–12 added — notably Lark is now the backup carrier of Clue 7 so the trail has no single point of failure. Jax Miller confirmed as Fixer. Open: cosmetic findings 6–9. Remaining prep: print handouts (monologue card ×2), generate art via `mj-gen` from the scenario's prompts table, GM read-through.

v2.3 continuity audit (Tim-requested; he's had date/name errors in past scenario work — always audit these): Aris b. 1998, pier memory 2007 (age 9), adult (33) at the 2031 callout, off-grid 2031 (= six years in 2037); Kade at Tyrell 2009–2022, gap, Wallace 2028–2031; death Wed 23:40, found Fri 10:15 (~35 hrs); **Sloane is a Nexus-9, serial SN9-1.11, 12 months** (not N8/SN8-1.11); Kael's examiner is Dr. Imani Okafor, Sloane's bakery is Castellano & Sons (renamed to avoid collision).

Portrait art mapping in the con folder: true portraits are `Rick.png`, `JAX copy ZOOM.png`, `KAEL copy.png`, `SLONE Zoom.png`; the `* Trans` PNGs are sheet scans, not portraits. Related: [[mapwright-module]], [[user_github]].
