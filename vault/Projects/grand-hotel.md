---
type: project
status: active
repo: none (not in git)
path: RPGS/Call/The Grand Hotel
updated: 2026-10-20
---

# THE GRAND HOTEL

**What it is** — Call of Cthulhu 7e short campaign, **4 online sessions, 4 pregens max**,
standalone (no event). White Mountain National Forest, NH, 23–28 Sept 1924.
Twin Peaks DNA in Lovecraft's woods: dead switchboard girl Doris Kettering, the
Ammonoosuc House hotel, a border roadhouse, a Mi-Go mine under the Presidential
Range. Picked from three pitches (others: *White Birch*, *The Double Edition*).

**Where it lives** — `RPGS/Call/The Grand Hotel/`, Keeper doc
`scenarios/the-grand-hotel.md`. Asset IDs `GH-ART-##`. House folder layout.

**Current state — v0.4, complete first draft with full production.**
- `scenarios/`: campaign overview + four session running sheets (scene keys, stat
  lines, clue tables, fallbacks, carry-forward).
- `reference/`: `hotel-layout.md` (room canon; change it first), `the-eleven.md`,
  `maps/` (6 hand-drawn SVG maps + builders in `maps/src/`).
- `handouts/`: 15 period documents (HTML src + PNG, `src/render.py`) plus 2 map
  handouts in `handouts/maps/`.
- `art/raw`: 16 plates + 18 portraits via mj-gen; `tools/art-queue.py` re-runnable
  (skips existing), rejects archived in `art/alternates/`.
- Presentation page: `tools/build-site.py` → `site/`, published as a private
  Artifact https://claude.ai/artifact/QSNtnU3HfQEjNHbYEKJJLc
- Audited 2026-10-20: Codex desk play + full agent playtest (Keeper + 4 player agents, all 4 sessions) + handout/map/art audits. Report: `playtest/2026-10-20-full-audit.md` — 4 BLOCKERs (finale dome/shaft/Seal undefined, Larch double-counted, Seal kills rescued cylinders, S4 start day), ~30 MAJOR. Fixes NOT yet applied. Not in git.

**Next steps**
- Tim approves the fix pass, then apply in the audit's order (blockers → "if they get ahead" boxes → H1-D split/H2-D hotel position → logic → rules → art re-rolls)
- Decide VTT (Foundry? → scenario-forge) and git repo

**Key decisions**
- Mythos is the Mi-Go played straight; the "occult sacrifices" are survey glyphs
  laid by a sleepwalking night manager (Pryce), not a cult rite.
- Period accuracy anchors: National *Forest*, NH medical referees (no coroners),
  no state police until 1937, Mount Pleasant not yet Eisenhower.
- Roster fixed at four by Tim (journalist, professor, retired cop, scientist);
  ranger and pathologist cut. Frank inherits the Cooper dreams; Dr. Rowe (NPC) does the autopsy.
- S1–2 research, S3–4 hotel-only (Tim, 2026-10-19). Gallery moved under the hotel and
  the climax into the hotel's Star Room so S3–4 never leave the building.
- Star Room finale confirmed by Tim (2026-10-19); the Cog/summit climb stays out.
- Canon fixes from the production agents: gallery under the kitchen garden (not the main block), Line House ~80 mi by road, Maine Central through the Notch, no "Route 3" (US numbering is 1926), Pell commissioned 1898.
- Agent playtest method (2026-10-20): Keeper agent writes beats to `playtest/agent-run-*/beats/`, players write action files; Keeper improvisations logged as K-items and excluded from the fix list.
