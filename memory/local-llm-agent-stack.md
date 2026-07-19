---
name: local-llm-agent-stack
description: "User's local on-device LLM agent stack — Hermes Agent + Ollama + Gemma 4 12B, and the gotchas hit while setting it up"
metadata: 
  node_type: memory
  type: project
  originSessionId: 597fb120-a859-4b1f-a39d-e7cb879e6b42
---

The user runs a **local, on-device AI agent stack** on their 32 GB Apple Silicon Mac (macOS 27): **Hermes Agent** (Nous Research) as the agent front-end, pointed at **Ollama** serving **Gemma 4 12B**. Set up 2026-06-15. This is separate from their other local-AI work (the `~/stable-diffusion-webui` project) and reflects a clear preference for self-hosted / privacy-preserving AI over cloud APIs.

**Why:** They explicitly asked to install Gemma 4 12B and connect Hermes "on my computer." Knowing the stack exists (and its quirks) avoids re-deriving it and informs future recommendations toward local solutions.

**How to apply:**
- Ollama runs as a Homebrew login service at `http://localhost:11434` (OpenAI-compatible API at `/v1`); it already launches with `OLLAMA_FLASH_ATTENTION=1` + `OLLAMA_KV_CACHE_TYPE=q8_0`.
- **Hermes requires ≥64K context.** Base `gemma4:12b` wasn't enough, so a `gemma4:12b-64k` Ollama variant was created via a Modelfile (`PARAMETER num_ctx 65536`). Hermes config (`~/.hermes/config.yaml`) uses provider=custom, model=`gemma4:12b-64k`, context_length=65536. Placeholder `OPENAI_API_KEY=ollama` lives in `~/.hermes/.env`.
- **Hermes was installed via `uv tool install hermes-agent`**, NOT the official `curl … install.sh` (the git clone kept failing on a flaky network) and NOT plain pip (system Python is 3.14, but the `hermes-agent` PyPI pkg needs Python <3.14 — uv provides a managed 3.11). CLI lives at `~/.local/bin/hermes`.
- Gemma 4 is a "thinking" model: over the `/v1` endpoint Ollama returns chain-of-thought in a `reasoning` field and the answer in `content` — don't cap max_tokens too low or `content` comes back empty.
- **GUI:** `hermes dashboard` serves a local web UI at http://127.0.0.1:9119 (bundled `web_dist`, runs with `--skip-build` — no Electron/repo needed; the `hermes desktop` Electron app would need the git repo we never cloned). Launched here as a setsid daemon; manage with `hermes dashboard --status/--stop`.
- **Tools configured (2026-06-16):** base `browser` tool works (drives the user's installed Google Chrome; set up via `hermes postinstall` + `hermes doctor --fix`). Web search via **Tavily** (`TAVILY_API_KEY` in `~/.hermes/.env`) — verified end-to-end through the agent. Hermes also ships keyless web providers (Brave-free, DDG) if ever needed.
- **Still pending / manual:** `computer_use` + `browser-cdp` report "system dependency not met" — `computer_use` needs macOS Accessibility + Screen-Recording grants (manual, can't be automated). Discord bot was requested: user creates app + `DISCORD_BOT_TOKEN`, then `hermes config set DISCORD_BOT_TOKEN/DISCORD_ALLOWED_USERS` + `hermes gateway install && start` (uses privileged Message Content Intent).
