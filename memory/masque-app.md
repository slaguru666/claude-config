---
name: masque-app
description: Masque — real-time GM voice changer (browser Web Audio + BlackHole + Node remote server + AI sidecar) at ~/masque; spec written 2026-08-23
metadata:
  type: project
---

Masque is Tim's real-time voice changer for running games over Discord/Teams/Zoom, started 2026-08-23. Repo `~/masque` (git; to push to Gitea `tevans/masque` + GitHub `slaguru666/masque`). Spec: `docs/superpowers/specs/2026-08-23-masque-voice-changer-design.md`.

Decisions: browser single-file Web Audio app (family of [[nexus-app]]/[[esper-app]]) on port 8770, DSP kernels isolated for a later native Swift port; Signalsmith Stretch WASM (`signalsmith-stretch@1.3.2`) for pitch/formant; routing `RØDE Connect Virtual → Masque → BlackHole 2ch → Discord`; control = keyboard + Web MIDI + tablet `/remote` via Node `ws` server; AI voice-conversion stage is v1 scope but its own spec 2 (Python sidecar, port 8771, Int16 PCM 48k 20 ms frames over WebSocket), which opens with a latency spike: RVC/MPS vs Beatrice v2 vs LLVC on this Mac.

**Built 2026-08-23 (branch merged to `main`):** Spec 1 core done and browser-verified — 52 Node tests green; measured chain latency 34-39 ms at 30 ms engine block, ~70 ms total; 14 presets switch click-free (86 switches, 0 glitches); keyboard/MIDI/tablet remote all work; server replays state to late remotes; built-in test-signal input for mic-less auditioning. Spec 2 AI sidecar done — Beatrice 2 (200 pretrained voices, MIT) runs on MPS after a 3-line float64->float32 patch; ~40 ms/hop, ~120 ms sidecar / ~225 ms total; ai/sidecar.py speaks the section-7 protocol; 5 Python tests green. Engine spike in ai/spike/RESULTS.md.

**Why:** Tim chose "A now, plan B port later", keyboard+MIDI+tablet control, AI voices in v1. Verified in the preview browser (mic blocked there so the test signal was used); a Discord smoke test with a real mic session is the one remaining manual check.
**How to apply:** run ./setup.sh (installs BlackHole — still not installed) then npm start. For AI: cd ai && uv sync && ./download_models.sh && uv run sidecar.py. Not yet pushed to Gitea/GitHub. Keep the AI engine on MPS — CPU is ~10x slower (no fast depthwise conv on macOS arm64).
