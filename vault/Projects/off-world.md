---
type: project
status: active
repo: github.com/slaguru666/ambiantsynth (public)
path: ~/Git/off-world/index.html
updated: 2026-09-19
---

# Off-World

**What it is** — A Blade Runner ambient generator that plays itself. No keyboard,
no chords to finger: every note is scheduled by the machine. Built as a published
Artifact, single file, Web Audio, no deps (~120 KB). The counterpart to
[[nexus-80]], which is the playable instrument.

**Where it lives** — https://claude.ai/artifact/TNvdgqjmbGdGVjmPXqCRvs
(capability `downloads`). Source in `~/Git/off-world` on `fedora` → GitHub `slaguru666/ambiantsynth`.

**Current state** — Fourteen generative layers (bed, pads, choir, brass, lead,
bells, sequence, pulse, percussion, sonar, rain, city, chatter, tape), each with
level/activity/tone/hall in a rack plus its own editor. A director runs scenes
(ten of them), sections, arcs and an autopilot that walks a neighbour graph. A
harmony grammar with per-degree weights, modes, colour and tension. Six macros and
an assignable XY weather pad. Texture rack: built IRs, shimmer, tape delay with
wow, ensemble, drive, crush, width, ducking. Activity log of what the engine just
decided. Take recorder, JSON export/import, four local slots.

**Next steps**
- Nothing is verified by ear here either — every claim about the sound is read off
  the audio graph.
- Possible: per-scene layer level automation, a longer-form "film" mode.

**Key decisions**
- Seeded RNG (mulberry32 over an FNV hash). A seed replays a world exactly, which
  only holds because the *sounding* key/mode live in `H` while the console's chosen
  origin stays in `S.h` — a modulation must not move the point a replay starts from.
- The harmony grammar is a weighted move table per degree; the "don't repeat the
  chord" rule re-picks from the same weighted pool, or the weights would be
  overruled by the anti-repeat.
- A hidden tab throttles `setInterval` to ~1 Hz, so the scheduler widens its
  horizon to 2.6s on `visibilitychange` rather than leaving holes.

Related: [[nexus-80]] · [[esper]] · [[drift]] · [[haunt]] · [[nexus]]
