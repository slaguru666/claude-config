---
name: afterimage-scenario
description: AFTERIMAGE — 4-player Blade Runner scenario for CONTINUUM 2026, Friday 24 July, Slot 2 (20:00–00:00); repo slaguru666/Continuum2026 (private)
metadata: 
  node_type: memory
  type: project
  originSessionId: 445b61b6-6e68-4f8e-8caa-28bf213400e9
  modified: 2026-07-19T10:56:54.351Z
---

AFTERIMAGE is the Blade Runner RPG scenario for **Continuum 2026** (continuumconvention.co.uk, Cranfield), **Friday 24 July 2026, Slot 2 = 20:00–00:00**, 4 players. *(Corrected 2026-07-19: it was originally mis-filed under Contingency 2026 Wed Slot 3 — the old repo `Contingency26` is now a pointer stub.)* Chamber-noir: memory designer Elias Kade dead; replicant copies of his estranged daughter Aris. **Restructured to v3.1 (Sep 2026) — the death is now an ACCIDENT, not an ambiguity.** Kade took the returned Aris by the wrists ("I still have your master. I can fix you the way I fixed the others"), she pulled away two-handed, he fell against his own rig and the spike in slot 3 entered his temple. Wren (a copy) found the body and left. Aris is "the Archivist", a black-market records-scrubber, and forged the house recording — but never knew Thursday's camera file existed, so it is clean and shows her leaving at 22:09. Acts: the death scene → find the two copies → all three women at the pier. Wallace interferes without combat; Corvin is unarmed by design. Foot chase in Act Two (night market); duplicated key-memory monologue handout (print F2-H02-A twice) is still the core reveal.

Locations: private GitHub repo `slaguru666/Continuum2026` (full history); local copy at `.../RPGS/Conventions/Continuum 2026/01 Friday/Slot 2 Evening Blade Runner/AFTERIMAGE/`. Asset IDs are `F2-*`; scenario file is `scenarios/fri-slot2-blade-runner-afterimage.md`.

Also in the repo: **REP-DETECT GM Console** (`gm-utility/index.html`) — Tim's touch-screen Blade Runner GM app; offline single-file HTML, localStorage per module + JSON export, animated idle screen (film-style Spinner + live rain), scenario modules via `BRGM.registerModule()` in `gm-utility/modules/` (AFTERIMAGE included). To add a scenario: new module JS + a script tag in index.html.

Status (v3.1 — restructured, re-audited, **not yet re-playtested**): rebudgeted to a hard 3-hour ceiling (Intro 15 · Act One 40 · break 5 · Act Two 55 · Act Three 40 · Epilogue 10 + 15 reserve; hard cut to the pier at 1:55). Adversarially reviewed by Codex as GM and as player — 17 findings, all triaged and applied. Art complete: 6 scene plates, 9 cast portraits, plus two hand-drawn SVG evidence plates (F2-ART-16 studio floorplan, F2-ART-17 Esper analysis). Print pack rebuilt to 16 handouts + cut-out sheet. **The three v2 playtest documents no longer describe this scenario — one full desk playtest at v3.1 is the outstanding prep.**

Foundry VTT module lives at `foundry/afterimage/` — `node build.mjs` builds and installs (quit Foundry first; the build refuses while it runs). 13 actors, 28 journals / 80 pages, 5 scenes, 1 table, one Adventure document for one-click import. The act journals are **generated from the scenario Markdown**, so the doc is the single source of truth and cannot drift. Gotcha: a Foundry Adventure re-import does NOT update world documents that already exist under the same ids — delete them and import clean, or you verify a stale copy.

Continuity anchors (Tim-requested audit; he's had date/name errors in past scenario work — always audit these): Aris b. 1998, pier memory 2007 (age 9), adult (33) at the 2031 callout, off-grid 2031 (= six years in 2037); Kade at Tyrell 2009–2022, gap, Wallace 2028–2031; death Wed **23:44** (forged window 23:31–23:48), Aris's earlier return a fortnight before, her second return Thu **22:09** on the clean camera, body found Fri 10:15 (~35 hrs); **Sloane is a Nexus-9, serial SN9-1.11, 12 months** (not N8); Kael's examiner is Dr. Imani Okafor; Sloane's bakery is Castellano & Sons.

Portrait art mapping (art also copied into the repo): true portraits are `Rick.png`, `JAX copy ZOOM.png`, `KAEL copy.png`, `SLONE Zoom.png`; the `* Trans` PNGs are sheet scans, not portraits. Related: [[mapwright-module]], [[user_github]].
