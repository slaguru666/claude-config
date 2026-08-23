---
name: grimoire-app
description: Grimoire — single-file "dark fantasy keys" preset instrument at ~/grimoire/ (40 presets in 6 categories, plugin-style knobs, arp, key lock, textures); modelled on Clark Audio Dark Fantasy Keys
metadata:
  type: project
---

"Grimoire" at `~/grimoire/index.html` (~460 lines, single file, Web Audio, no deps, no samples) with README.md; launch config `grimoire` in `~/.claude/launch.json` serves port 8768. Built 2026-08-22 when the user asked for "something like" Clark Audio's Dark Fantasy Keys VST (40 presets, categories Liminal Journey / Angel Garden / Dungeon Synth / Enchanted Spell / Scrolls / The Healer, load-and-play).

Architecture: layer library (epiano, piano, celesta, harpsi, clavi, musicbox, bell, glock, tubular, glass, pad, choir, strings, organ, drone, flute, lute, harp, sub) → presets stack 1–3 layers; FX chain drive → chorus → worn (wow/crusher/tilt/crackle) → synced delay → reverb (4 impulses) with octave-up shimmer pitch-shifter → air → tone → width → limiter. Rotary knob UI component. Arp, key lock, texture beds, favourites, user presets, Conjure randomizer, export/import, WAV record. Storage via guarded LS helper (keys grimoire-user/favs/state). `window.grimoire` exposes API.

**How to apply:** fourth sibling of Drift/Esper/Haunt ([[ambient-synth]], [[esper-app]], [[haunt-app]]). Not in git; ask before creating a repo.
