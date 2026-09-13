---
type: project
status: complete
repo: none — not in git
path: ~/ambient-synth
updated: 2026-09-13
---

# Drift

**What it is** — An ambient groovebox: vanilla JS + Web Audio, one static HTML file
(~1850 lines), no deps, no build. The first of the five audio apps.

**Where it lives** — `~/ambient-synth/index.html`, launch config `drift`, port
**8765**. Hosted since 2026-09-08 at `https://web.oneoffgames.com/sound/drift.html`
as one of the five in the SOUND suite ([[oneoffgames-vps]]). The local port is still
the place to edit; deploying is a copy of `index.html` into
`/var/www/web.oneoffgames.com/sound/`.

**Current state** — Complete. Groovebox transport (tempo, swing, key/scale, 8
patterns, song chain, Rec overdub, Bounce to WAV, MIDI in), Master (pump sidechain,
DJ filter, delay/reverb), Pad, CS-80 two-layer engine, Offworld (Blade Runner-style
generator: 8 scenes, 6 moods), Beats (8 synthesised drums), Acid (303), Chords,
Melody. State auto-saves to localStorage `drift-state-v4`.

**Next steps** — none. Tim has not listened to the later waves (built overnight
autonomously).

**Key decisions**
- Kept as **one static file** for zero-setup portability.
- **Not in git and not pushed anywhere.** Ask before creating a repo.

**Gotchas**
- `window.drift` exposes everything for scripted browser tests.
- When Tim's own http.server is on 8765, use `preview_start` with a URL rather than
  the named launch config.
- Browser-pane screenshots come back blank after scrolling a hidden pane — verify
  via JS metrics instead.

Related: [[esper]], [[haunt]], [[grimoire]], [[nexus]]
