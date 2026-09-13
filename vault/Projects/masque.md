---
type: project
status: active
repo: not pushed — planned tevans/masque + slaguru666/masque
path: ~/masque
updated: 2026-09-13
---

# Masque

**What it is** — A real-time voice changer for running games over Discord, Teams or
Zoom. Started 2026-08-23. Browser single-file Web Audio app, family of [[nexus]] and
[[esper]], with DSP kernels isolated for a possible native Swift port later.

**Where it lives** — `~/masque` (git, `main`), port 8770. Spec at
`docs/superpowers/specs/2026-08-23-masque-voice-changer-design.md`. **Not yet pushed
anywhere.**

**Current state** — Built and verified. Spec 1 core: 52 Node tests green, measured
chain latency 34–39 ms, ~70 ms total, 14 presets switching click-free (86 switches,
0 glitches), keyboard / MIDI / tablet remote all working. Spec 2 AI sidecar: Beatrice 2
(200 pretrained voices, MIT) runs on MPS after a three-line float64→float32 patch;
~40 ms/hop, ~225 ms total.

After 2026-09-07 there are **three usable pages**: `voice.html` (minimal — mic in,
voice out, two sliders), `studio.html` (65 voice presets across 9 categories, 9
stackable layer FX, live pitch/formant, search), and `index.html` (the original
complex Discord/AI console).

**Next steps**
- Push to Gitea and GitHub
- Install BlackHole via `./setup.sh` — still not installed, and nothing routes to
  Discord without it
- One Discord smoke test with a real mic

**Key decisions**
- 2026-09-07 — Tim found the big multi-panel app was **not what he wanted**; he
  wanted the simple "talk in, hear voice changed" thing. That drove `voice.html` and
  then `studio.html`. Keep the simple page simple.
- Routing: RØDE Connect Virtual → Masque → BlackHole 2ch → Discord, with a separate
  monitor path to headphones. Monitor volume goes to 300% (default 150%) because the
  original was too quiet.
- Signalsmith Stretch WASM for pitch and formant.

**Gotchas**
- Keep the AI engine on **MPS** — CPU is ~10× slower, no fast depthwise conv on
  macOS arm64.
- The preview browser blocks the mic; verification uses the built-in test signal.

Related: [[nexus]], [[esper]], [[drift]]
