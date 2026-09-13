---
type: project
status: complete
repo: none — not in git
path: ~/grimoire
updated: 2026-09-13
---

# Grimoire

**What it is** — A dark-fantasy keys preset instrument, built 2026-08-22 when Tim
asked for "something like" Clark Audio's Dark Fantasy Keys VST: 40 presets, load and
play. Single file, Web Audio, **no samples** (~460 lines).

**Where it lives** — `~/grimoire/index.html`, launch config `grimoire`, port
**8768**. Hosted at `https://web.oneoffgames.com/sound/grimoire.html`
([[oneoffgames-vps]]).

**Current state** — Complete. Categories: Liminal Journey, Angel Garden, Dungeon
Synth, Enchanted Spell, Scrolls, The Healer. A layer library of 19 voices (epiano,
piano, celesta, harpsi, clavi, musicbox, bell, glock, tubular, glass, pad, choir,
strings, organ, drone, flute, lute, harp, sub); presets stack 1–3 layers. FX chain:
drive → chorus → worn (wow, crusher, tilt, crackle) → synced delay → reverb with
octave-up shimmer → air → tone → width → limiter. Rotary knob UI, arp, key lock,
texture beds, favourites, user presets, Conjure randomiser, WAV record.

**Next steps** — none.

**Key decisions**
- Not in git. Ask before creating a repo.

Related: [[drift]], [[esper]], [[haunt]], [[nexus]]
