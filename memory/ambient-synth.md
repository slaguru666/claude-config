---
name: ambient-synth
description: Drift — single-file Web Audio ambient groovebox (pad, CS-80 engine, 303 acid, 8-drum kit, chords, melody gen, song mode, bounce-to-WAV, Blade Runner-style Offworld generator) at ~/ambient-synth/
metadata:
  type: project
---

"Drift" ambient groovebox, built 2026-08-21/22. Lives at `~/ambient-synth/index.html` (~1850 lines, plus README.md and `.claude/launch.json` config named `drift`, port 8765 via `python3 -m http.server`). Vanilla JS + Web Audio, no deps, no build. State auto-saves to localStorage key `drift-state-v4`; Export/Import project JSON.

Sections: Groovebox transport (tempo, swing, key/scale, pattern length 8–64, 8 patterns, song chain with per-section D/A/C/M mutes, loop/play-once, fill, Rec overdub, Bounce to WAV / Bounce whole song, MIDI in), Master (pump sidechain, DJ filter, delay/reverb/volume), Pad, CS-80 (two-layer engine with PWM, ring mod, touch, 8 presets), Offworld (Blade Runner-style generator: 8 scenes, 6 moods, drone/wind/rain/sparkle/shimmer/e-piano/choir/lead swells/boom+risers, bar-sync), Beats (8 synthesized drums, per-drum level/tune/decay/mute, style generators, humanise), Acid (303 + 4 bass styles), Chords (diatonic stab track, live chord keys), Melody (lead/CS-80/pad, random-walk gen).

**Why:** user asked for an ambient synth with piano keys, then 303, beats/groovebox/melody/Blade Runner ambient, then song mode + recording + CS-80, then house/techno groovebox, more Blade Runner, drum control and custom length. Kept as one static file for zero-setup portability. Overnight autonomous session ("make it amazing") — the user has not yet listened to the later waves.

**How to apply:** serve the folder and click "Start audio". `window.drift` exposes everything for scripted browser tests. Not in git and not pushed anywhere — ask before creating a repo (user's GitHub: [[user-github]]). When the user's own http.server is on 8765, use `preview_start` with a URL rather than the named launch config. Browser-pane screenshots were blank after scrolling (hidden pane), so verify via JS metrics.
