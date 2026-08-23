---
name: nexus-app
description: Nexus — single-file cinematic score workstation at ~/nexus/ combining Blade Runner, horror, sci-fi horror, Alien and dramatic-cinema worlds (18 scenes, mood XY pad, arcs, 16 cue pads, split keys with 20 voices, 42 layers, FX rack)
metadata:
  type: project
---

"Nexus" at `~/nexus/index.html` (~590 lines, single file, Web Audio, no deps) with README.md; launch config `nexus` in `~/.claude/launch.json` serves port 8769. Built 2026-08-22 as the capstone "combined tool" the user asked for (Blade Runner + horror + sci-fi horror + Alien + dramatic cinema, designed as a tool, playable).

Structure: Director (5 worlds → 18 scenes, Wonder↔Dread × Calm↔Intense XY pad driving voicings and pulse layers, arcs Build/Tension/Release/Chase/Trailer/Aftermath/Nightmare, evolve, journey, chord chips), Cue pads (16 one-shots on number row + QWER), Keys (split at C4, 20 voices incl. CS-80 presets, dark pad, epic/sul-pont strings, choirs, organ, piano, CS-80 lead, Alien echoplex trumpet, braam, taiko, hit; play modes poly/ostinato/arp/chord/pulse; key lock; harmony; sustain), Layers (42), Manipulations (Haunt's rack + sub boost + trailer squash), Studio (WAV record, snapshots, Dream, export/import). State in localStorage `nexus-v1` via guarded LS helper. `window.nexus` exposes everything.

**Gotcha fixed:** a percussion `tick()` clobbered the transport `tick()` (same-scope function declarations) → stack overflow; percussion is now `tickSound`. Watch for duplicate function names when merging app code.

**How to apply:** fifth sibling of [[ambient-synth]], [[esper-app]], [[haunt-app]], [[grimoire-app]]. Browser tests in <25 s batches. Not in git; ask before creating a repo.
