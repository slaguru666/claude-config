---
type: project
status: complete
repo: none — not in git
path: ~/nexus
updated: 2026-09-13
---

# Nexus

**What it is** — The capstone combined cinematic score workstation: Blade Runner,
horror, sci-fi horror, Alien and dramatic cinema in one tool. Designed as a tool,
and playable. Single file, Web Audio, no deps (~590 lines). Built 2026-08-22.

**Where it lives** — `~/nexus/index.html`, launch config `nexus`, port **8769**.
Hosted at `https://web.oneoffgames.com/sound/nexus.html` ([[oneoffgames-vps]]).

**Current state** — Complete. Director (5 worlds → 18 scenes; a Wonder↔Dread ×
Calm↔Intense XY pad driving voicings and pulse layers; arcs Build/Tension/Release/
Chase/Trailer/Aftermath/Nightmare). Cue pads (16 one-shots on the number row and
QWER). Keys (split at C4, 20 voices including CS-80 presets, sul-pont strings,
choirs, Alien echoplex trumpet, braam, taiko; play modes poly/ostinato/arp/chord/
pulse). 42 layers. Manipulations (Haunt's rack plus sub boost and trailer squash).
Studio (WAV record, snapshots, Dream, export/import). State in `nexus-v1`.

**Next steps** — none.

**Key decisions**
- Not in git. Ask before creating a repo.

**Gotchas**
- A percussion `tick()` once clobbered the transport `tick()` — same-scope function
  declarations — producing a stack overflow. Percussion is now `tickSound`. **Watch
  for duplicate function names when merging app code.**

Related: [[drift]], [[esper]], [[haunt]], [[grimoire]], [[masque]]
