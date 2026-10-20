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

**Current state — v0.5, audited and fixed.**
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
- Audited 2026-10-20 (Codex + agent-played campaign + handout/map/art audits, `playtest/2026-10-20-full-audit.md`); **fix pass applied same day (v0.5)** — change logs `playtest/2026-10-20-fixes-{scenarios,handouts-maps,art}.md`. Still imperfect: Outerbridge portrait face, ART-06 mark placement, 13/15 figure and chair counts. Not in git.

**Next steps**
- Tim's read of v0.5; optional second agent playtest of S3–S4 to test the new dome mechanism and "If they get ahead" boxes
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
- Finale mechanism (2026-10-20): the harvest needs ring + open dome + midnight; Mi-Go come over the roofs from the old well-house (gallery shaft surfaces in the kitchen garden, not the tower). Choices: Close the dome / Collapse (dynamite; kills only cylinders still below) / Free / Bargain / Fenn turn / Larch accepts (in place of the other ten).
- Summit bodies: the Mi-Go carried and marked Breck and Thomas; Pryce only copies marks onto the lawn cairn. Doris's ledger hides behind the switchboard jack panel. Voice digit group 247 → 261 (summit-station bearing); Pell's log now N 85° W.
