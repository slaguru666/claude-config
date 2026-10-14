---
name: freshwater-scenario
description: FRESH WATER — the first one-page Custodians case; 1923 liner, 18 scraperboard plates, run by showing pictures.
metadata:
  type: project
---

FRESH WATER is a Custodians (RingBRP) crossing case written 14 Oct 2026, and the shelf's
**first deliberately one-page scenario** — the document is an index and **the 18 plates are the
scenario**. Lives in [[ringbrp-project]] at `docs/scenarios/FRESH_WATER.md`, art prompts in
`FRESH_WATER_ART.md`, pack spec in `tools/scenario-freshwater.mjs`, pack `packs/freshwater`.

The case: RMS *Calpurnia*, Liverpool–New York, foundered 17 March 1923. Fire in number four
hold; the crew flooded it to save her, which was **correct** and which sank her and put the
cargo into the sea. Four agents come through onto the rescue ship *Dunbarrow* at dawn with 36
hours to New York. Anyone who was in the water is seeded and **no roll detects it**; hot fresh
water is the cure and the ship can heat about **90 baths for 603 survivors**. Solved by the
**boat list** (wash the four boats that shipped water) and then by the **"reachers"** — about
thirty people who leaned into the sea from a dry boat and are not lying when they say they were
never in it.

Three decisions worth not re-litigating:
- **One journal page**, because splitting a one-page case across twelve pages undoes it.
- **"One page" is measured** by `node tools/make-pdf.mjs <doc> --onesheet` (new mode: 2 columns,
  7.6pt, no cover) and counting the PDF's pages. See [[feedback-measure-the-constraint]].
- **The contaminant gets no stat block** — no body, nothing it can do inside the clock. Only
  `cal_turned` and `cal_landed` are actors.

Art direction is **scraperboard, white line out of solid black**, distinct from ONE MORE
ABOARD's 1912 two-ink engraving. Nobody is in the water in any plate; plate 11 has no figures
at all. `fw_11_wash` was pulled by moderation once (bathing language) — reworded version is in
the art sheet. Still outstanding: a desk pass, the printed boat list handout, and a slot.
