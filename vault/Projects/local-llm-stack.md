---
type: project
status: complete
repo: none
path: ~/.hermes
updated: 2026-09-13
---

# Local LLM agent stack

**What it is** — A local, on-device AI agent stack on the 32 GB Apple Silicon Mac:
**Hermes Agent** (Nous Research) as the front end, pointed at **Ollama** serving
**Gemma 4 12B**. Set up 2026-06-15. Reflects a standing preference for self-hosted,
privacy-preserving AI over cloud APIs.

**Where it lives** — Ollama runs as a Homebrew login service at
`http://localhost:11434` (OpenAI-compatible at `/v1`). Hermes config at
`~/.hermes/config.yaml`, CLI at `~/.local/bin/hermes`. Dashboard at
`http://127.0.0.1:9119` via `hermes dashboard`.

**Current state** — Working. Browser tool drives the installed Chrome; web search via
Tavily, verified end to end.

**Next steps**
- `computer_use` and `browser-cdp` report "system dependency not met" —
  `computer_use` needs macOS Accessibility and Screen-Recording grants, which are
  manual
- A Discord bot was requested: Tim creates the app and token, then
  `hermes gateway install && start`

**Key decisions**
- **Hermes requires ≥64K context.** Base `gemma4:12b` wasn't enough, so a
  `gemma4:12b-64k` variant was created via a Modelfile with `num_ctx 65536`.
- Installed via `uv tool install hermes-agent`, not the official installer (the git
  clone kept failing) and not pip (system Python is 3.14; the package needs <3.14, so
  uv provides a managed 3.11).

**Gotchas**
- Gemma 4 is a thinking model: over `/v1`, Ollama returns chain-of-thought in a
  `reasoning` field and the answer in `content`. Cap `max_tokens` too low and
  `content` comes back empty.

Related: [[notebooklm]], [[clipsync-macmem]]
