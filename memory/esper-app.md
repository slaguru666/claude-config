---
name: esper-app
description: Esper — single-file generative Vangelis/CS-80/Blade Runner machine at ~/esper/ (14 styles, 26 layers, master FX rack, performance/conductor/studio panels); sibling of Drift
metadata:
  type: project
---

"Esper" generative Vangelis-style app at `~/esper/index.html` (~1000 lines, single file, Web Audio, no deps) with README.md; launch config `esper` in `~/.claude/launch.json` serves port 8766. Built 2026-08-22, expanded the same day on the user's "lots and lots more functions" request.

Panels: Style & tempo (14 styles, tempo/key/scale override, chord chips with hold/next/randomize), Layers (26 per-sound levels incl. whale, spinner, thunder, city hum, machinery, radio, heartbeat, glass, bell tower, tape), Manipulations (ensemble chorus, wow/flutter, phaser, lo-fi, gate, tremolo, master filter + breathe, delay sync/ping-pong, reverb spaces, warmth/air, drift, width, half-time, Freeze), Performance (keys voices, arpeggiator, sustain, lead/pad/bass/drum overrides, harmony), Conductor (Evolve, Journey, cue buttons), Studio (WAV record, 4 snapshots, Dream randomizer, export/import, themes, spectrum scope). State in localStorage `esper-v2` (+ `-snap1..4`). `window.esper` exposes internals.

**Why:** user wanted a second app "very Blade Runner, CS-80 Vangelis based" with style/tempo controls, then asked to massively increase functions and ambient elements — distinct from the Drift groovebox ([[ambient-synth]]).

**How to apply:** CS-80 engine shares lineage with Drift — port fixes both ways. Browser test scripts must stay under ~25 s per call (tool timeout). Not in git; ask before creating a repo.
