---
type: project
status: active
repo: github.com/slaguru666/bladerunnersynth (public)
path: ~/Git/nexus-80/index.html
updated: 2026-09-19
---

# Nexus-80 Ribbon Synth

**What it is** — A Blade Runner / Vangelis CS-80 in the browser, built as a
published Artifact rather than a local app. Single file, Web Audio, no deps
(~160 KB). Distinct from [[nexus]] and [[esper]], which are earlier local tools
on the same theme.

**Where it lives** — https://claude.ai/artifact/SpZHw1B2tpSGkbqrga1ymV (Version 6,
capability `downloads`). Source in `~/Git/nexus-80` on `fedora` → GitHub `slaguru666/bladerunnersynth`.

**Current state** — Dual-channel CS-80 voice (HP + resonant LP, split envelopes,
ribbon, pressure), LFO 2 with tempo sync and S&H, formant choir, Rhodes, shimmer
reverb. Continuum: Eno tape-loop pads on non-aligning periods, Riley *In C* cell
engine, melody motif work, custom progression editor. Rhythm unit: 10 voices,
per-voice Euclid/probability/length, A/B banks with chaining. 303-style bass with
accent/slide/ratchet. Performance: arp, keyboard split, 4-layer looper, XY pad,
tap tempo, patch mutation, take recorder (MediaRecorder → webm → downloads), JSON
setup export/import.

**Next steps**
- Song/arrangement mode (deferred once already).
- Nothing is verified by ear — every claim about the sound is inference from the
  graph, not listening.

**Key decisions**
- Verification is a headless-Chromium harness that logs assertions into a `<pre>`
  the screenshot reads back (`mktest.sh`), plus `node --check`. Audio-param reads
  under that frozen clock are stale by construction — `setTargetAtTime` has not
  run — so tests assert the *target*, never `.value`.
- Recording saves `.webm`: `wav` is outside the downloads extension allowlist.

Related: [[nexus]] · [[esper]] · [[drift]] · [[haunt]]
