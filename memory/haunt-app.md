---
name: haunt-app
description: Haunt — single-file generative horror-ambience app at ~/haunt/ (14 scenes, 36 layers, FX rack with ring mod/distortion, tension arc with jump scares); sibling of Esper and Drift
metadata:
  type: project
---

"Haunt" horror ambience machine at `~/haunt/index.html` (~770 lines, single file, Web Audio, no deps) with README.md; launch config `haunt` in `~/.claude/launch.json` serves port 8767. Built 2026-08-22 on the user's "do the same for another app, horror ambiance" request, mirroring Esper's six-panel architecture ([[esper-app]]).

Scenes: asylum, woods, house, boiler, ritual, cosmic, hospital, ship, cornfield, crypt, station, cabin, carnival, numbers. Master params: tension (drives everything), pulse, key, scale, dissonance, darkness, proximity. 36 synthesised layers incl. whispers, breathing, footsteps, creaks, knocks, chains, crows, wolves, numbers-station voice, screams, giggle, Shepard tone, reverse swells, stingers. Conductor: tension arc → jump scare (silence gain node → stinger/scream/flash), evolve, journey, 16 cues. Studio: WAV record, snapshots, Nightmare randomizer, export/import. State in localStorage `haunt-v1`. `window.haunt` exposes everything.

**How to apply:** same test approach as Esper (batches under ~25 s). Not in git; ask before creating a repo. The three apps (Drift, Esper, Haunt) share helper code by copy — port fixes across.
