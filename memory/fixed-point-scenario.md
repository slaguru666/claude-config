---
name: fixed-point-scenario
description: "FIXED POINT — the Ringworld/Custodians crossing case in RingBRP: outline, nine printed handouts with computed charts, twenty pen-and-ink plates"
metadata:
  node_type: memory
  type: project
  modified: 2026-11-04T19:00:00.000Z
---

# FIXED POINT (RingBRP scenario, started 4 Nov 2026)

A Custodians crossing case built on Larry Niven's Ringworld, in `docs/scenarios/FIXED_POINT.md`
(+ `_ART.md`, `_HANDOUTS.html`), pack `fixedpoint`, build module `tools/scenario-fixedpoint.mjs`.

**The premise, because it is the thing worth not losing.** Earth's axis is walking in discrete
steps. The Bureau triangulates a locus and crosses to it; the agents come out on flat grass and
**are not told where they are** — the horizon tells them, about forty minutes later. The ring's
station-keeping is correcting against a mass that is not there, because something wrote itself
into the machine's list of what exists. **The fix is filing, not engineering**: strike the row
out (and it is then unaccounted for — the epilogue is a new row in the Bureau's own ledger), or
set its mass to zero (it stays filed and located, which is the responsible answer).

**Why the premise is sound rather than invented.** The ring is genuinely not in *stable*
equilibrium — the famous objection, chanted at Niven by MIT students at the 1971 Worldcon — and
his answer in *The Ringworld Engineers* (1979) is attitude jets holding station. The scenario
does not invent the flaw; it asks what the correcting machine is reading. See
[[ringbrp-project]].

**Figures are self-consistent and nothing guards them.** `check-figures` records this document
at **0** unmarked figures, which means its vocabulary cannot see degrees, kilometres or
intervals — so the arithmetic was checked by hand: obliquity 23.4367 + 3 x 0.31 = 24.37 now,
ceiling 24.50, fourth step 24.68, each step about 2,400 years of normal change at 47"/century.
Ring radius 1 AU, so it is **300 million km across, not 150** — that error was in the first
draft. The handout generator `tools/fixedpoint-handouts.mjs --check` asserts the deadline still
exists; run it before trusting the charts.

**Art: the arch renders at night and vanishes by day.** Identical composition, two lightings,
one rendered. **A description of faintness renders as absence** — the same trap as "barely more
than a mark on the paper". Light it, or specify faintness as a technique ("two fine parallel
edges with light stippling between them"). Recorded in the art sheet. See [[midjourney_bridge]].

**`&ldquo;`/`&rdquo;` break check-handouts.** `packWords` decodes `&rsquo;` and friends but not
the double-quote pair, so a word touching one never matches and the pack reads as drifted. Use
literal " " characters in handout HTML.
