---
type: project
status: complete
repo: slaguru666/Continuum2026
path: RPGS/Conventions/Continuum 2026/01 Friday/Slot 2 Evening Blade Runner/AFTERIMAGE
updated: 2026-09-13
---

# AFTERIMAGE

**What it is** — The Blade Runner RPG scenario for [[continuum-2026]], **Friday 24
July 2026, Slot 2, 20:00–00:00**, 4 players. Chamber-noir: memory designer Elias
Kade is dead, and there are replicant copies of his estranged daughter Aris. Also
ported to [[contingency-2027]]. The exemplar the [[rpg-skill]] was distilled from.

**Where it lives** — `slaguru666/Continuum2026`, scenario file
`scenarios/fri-slot2-blade-runner-afterimage.md`. Asset IDs are `F2-*`. Foundry
module at `foundry/afterimage/` — `node build.mjs` builds and installs.

**Current state — v3.2, convention-ready.** Desk-playtested in full from the GM chair
at v3.1 on 2026-09-11: **2:47 on the clock**, inside the 3-hour ceiling, honest dice,
chase run round by round. Fifteen findings, all applied in v3.2. Art complete: 6
scene plates, 9 cast portraits, 2 drawn SVG evidence plates. Foundry module current.
**Print pack printed and repaired 2026-09-13** — 22 handouts plus a cut-out sheet,
23 sheets. The exported PDF was from July, built before the ID cards and blueprints
existed; rendering the current HTML found four spill pages invisible on screen.

**Next steps**
- Tim's read-through (the pack itself is printed — `print/AFTERIMAGE-handouts.pdf`, 23pp)
- Resolve the **F2-H02-E collision**: the printed pack has used it for the night-market
  plan since 2026-09-11 (`f6fb48c`); the scenario's handout table gave the same ID to the
  props sheet on 2026-09-13 (`a18f3eb`). Renumbering touches the scenario text and the
  Foundry module, so it was left for a decision.

**Key decisions**
- **The shrine alley is its own sheet (F2-H02-G).** It shared a page with the night
  market while its own GM note said not to show it until the chase ended there — an
  instruction the sheet made impossible to obey.
- **The death is an accident, not an ambiguity** (restructured v3.1). Kade took the
  returned Aris by the wrists; she pulled away two-handed; he fell against his own
  rig. Wren, a copy, found the body and left.
- Aris forged the house recording, but never knew Thursday's camera file existed —
  so that file is clean and shows her leaving at 22:09.
- The Act Three lever is no longer an opposed roll with no failure branch: declaring
  the accident is **automatic**, and the roll only decides how much Corvin salvages.
- Slot Zero is explicitly outside the clock — book 3h20, run 3h00.
- Cut-to-the-climax time is **1:55** (it was stated three times and disagreed).

**Continuity anchors** — audit these every time; date and name errors have happened
before. Aris b. 1998, pier memory 2007 (age 9), adult at the 2031 callout, off-grid
2031. Kade at Tyrell 2009–2022, Wallace 2028–2031. Death Wed **23:44** (forged window
23:31–23:48); Aris's second return Thu **22:09** on the clean camera; body found Fri
10:15. **Sloane is a Nexus-9, serial SN9-1.11**, not an N8. Kael's examiner is
Dr Imani Okafor.

**Gotchas**
- A Foundry Adventure re-import does **not** update world documents that already
  exist under the same ids — delete and import clean, or you verify a stale copy.
- The Foundry build refuses to run while Foundry is open. Quit it first.
- Playtests 01–03 describe the v2 scenario and no longer transfer.
- The `* Trans` PNGs are sheet scans, not portraits.

Related: [[the-director]], [[midjourney-bridge]]
