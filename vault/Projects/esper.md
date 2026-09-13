---
type: project
status: complete
repo: none — not in git
path: ~/esper
updated: 2026-09-13
---

# Esper

**What it is** — A generative Vangelis / CS-80 Blade Runner machine. Single file,
Web Audio, no deps (~1000 lines). Built 2026-08-22 as a deliberately different thing
from the [[drift]] groovebox.

**Where it lives** — `~/esper/index.html`, launch config `esper`, port **8766**.
Hosted at `https://web.oneoffgames.com/sound/esper.html` ([[oneoffgames-vps]]).

**Current state** — Complete. Six panels: Style & tempo (14 styles, chord chips),
Layers (26 sounds including whale, spinner, thunder, city hum, machinery, radio,
heartbeat, bell tower, tape), Manipulations (ensemble chorus, wow/flutter, phaser,
lo-fi, gate, tremolo, filter + breathe, delay, reverb spaces, drift, width,
half-time, Freeze), Performance (keys, arpeggiator, harmony), Conductor (Evolve,
Journey, cues), Studio (WAV record, 4 snapshots, Dream randomiser, themes, scope).
State in localStorage `esper-v2`.

**Next steps** — none.

**Key decisions**
- Not in git. Ask before creating a repo.

**Gotchas**
- The CS-80 engine shares lineage with [[drift]] — port fixes both ways.
- Browser test scripts must stay under ~25 s per call or the tool times out.

Related: [[drift]], [[haunt]], [[grimoire]], [[nexus]]
