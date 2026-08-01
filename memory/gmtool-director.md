---
name: gmtool-director
description: "The Director" — offline-first convention GM tablet app (repo slaguru666/gmtool)
metadata:
  type: project
---

**The Director** (repo `slaguru666/gmtool`, package name `gm-director`) — an offline-first PWA
for running tabletop RPG sessions at conventions. Vanilla ES modules + Web Components (light DOM)
over pure, deterministic core logic (injected `now`/`rng`); Vite + Vitest/jsdom; no runtime deps.
Permanent feature is the always-on **Director Rail** (session clock + drift + next hard trigger).

State (2026-07-20): Slices 1–5 all complete. Slice 5 = the **convention hub** (`<con-hub>` +
pure `src/con/schedule.js`, live-now/up-next, deep-links via `src/scenarios/index.js` registry;
shell routes hub↔session). All **six** Continuum 2026 slots are ported into scenario modules and
scheduled with real times in `src/con/continuum-2026.js`.

Correction to the old slate note: Continuum 2026 is **six** GM'd slots, not five — Slot 5
**By the Light of the Silvery Moon** (CoC Gaslight) was missing, and Slot 6 is *Get to the Chopper —
Another Fine Mess*. Full slate: Fri S1 Day One (BRP), Fri S2 AFTERIMAGE (Blade Runner), Sat S4 The
Vain Crown (VANITY), Sat S5 Silvery Moon (CoC Gaslight), Sun S6 Chopper (Pulp Cthulhu), Sun S7 The
Princes Bride (Dee Sanction). Scenario source-of-truth for timelines is the `gm-utility/*console`
files in the [[afterimage-scenario]] repo `slaguru666/Continuum2026`.

All six scenarios' **clue trails AND NPC cast rosters are ported** (transcribed from the console
sources): clues feed the Slice 4 safety-net; cast feeds `<cast-tray>` (tap-to-reveal secrets).
**Every design §5 tray tool is now built**: dice (6 packs incl. a dedicated `brp-d100` for Day One),
NPC, art, clue-net, cast-tray, break-timer (pauses the clock so breaks don't poison drift),
parking-lot (timestamped thread capture), and a wake-lock toggle. Rail chips: 🏠🎲👤✏️🔍👥☕📝💡.
Also a **markdown→scenario-data generator** (`tools/scenario-md.js` + `npm run gen:scenario`): a
deterministic parser over a defined structured-markdown format (frontmatter + Timeline/Clues/Cast
lists), validated before emit; `tools/` is dev-only, never bundled. **Online art "Generate"** is also
built: the art tray generates pencil art via a GM-configured endpoint (nothing hardcoded — paste the
URL in the ⚙ field) and caches results into a persisted, searchable library; degrades gracefully
offline/unconfigured. The **native iPad wrapper** is scaffolded too: a Capacitor 8 iOS shell
(`capacitor.config.json`, `@capacitor/{core,cli,ios}` devDeps, `ios:*` npm scripts, SW skipped under
Capacitor, `docs/native-ipad-wrapper.md` build guide). Generating/building the actual iOS project
needs a Mac with **full Xcode + CocoaPods** (this Mac mini has only Command Line Tools, no pods) — so
that step is documented for the user to run, not done. ~211 tests. **The whole design is now built** —
The Director is convention-ready for Continuum 2026.
