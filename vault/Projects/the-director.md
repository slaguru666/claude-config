---
type: project
status: complete
repo: slaguru666/gmtool
path: ~/gmtool
updated: 2026-09-13
---

# The Director

**What it is** — An offline-first PWA for running tabletop sessions at conventions,
on a tablet. Package name `gm-director`. Vanilla ES modules and Web Components over
pure deterministic core logic (injected `now`/`rng`); Vite + Vitest; no runtime deps.
The permanent feature is the always-on **Director Rail**: session clock, drift, and
the next hard trigger.

**Where it lives** — `slaguru666/gmtool`.

**Current state** — Slices 1–5 all complete; ~211 tests. The whole design is built
and convention-ready. Slice 5 is the convention hub with live-now / up-next and
deep links. All six Continuum 2026 slots are ported into scenario modules and
scheduled with real times. Every tray tool exists: dice (6 packs), NPC, art,
clue-net, cast-tray, break-timer, parking-lot, wake-lock. Clue trails *and* NPC cast
rosters are ported for all six scenarios. A Capacitor 8 iOS shell is scaffolded.

**Next steps**
- Generating the actual iOS project needs a Mac with **full Xcode + CocoaPods** —
  this Mac has Command Line Tools only. Documented for Tim to run, not done.

**Key decisions**
- The break-timer pauses the session clock, so breaks don't poison drift.
- Online art generation uses a GM-configured endpoint pasted into a settings field —
  nothing hardcoded — and degrades gracefully offline.
- `tools/` (including the markdown→scenario-data generator) is dev-only and never
  bundled.

**Gotchas**
- Scenario source-of-truth for timelines is the `gm-utility/*console` files in the
  [[continuum-2026]] repo, not the scenario Markdown.

Related: [[continuum-2026]], [[afterimage]], [[rpg-skill]]
