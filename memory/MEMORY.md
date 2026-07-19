# Memory index

- [Midjourney bridge](midjourney_bridge.md) — `mj-gen "<prompt>"` drops a PNG on disk; full pipeline via Discord, no MJ API needed.
- [GitHub account](user_github.md) — username: slaguru666; 19 repos, mostly SLA Industries Foundry VTT modules.
- [Semaphore Gitea URL](feedback_semaphore_gitea_url.md) — use `http://gitea:3000/tevans/<repo>.git` inside Semaphore, not the external Cloudflare URL
- [Canvas OSS course](canvas_oss_course.md) — Canvas test server canvas.timevans.uk + `~/gema-oss-canvas-course/` idempotent course-builder (pin account id 1).
- [Mapwright module](mapwright-module.md) — new standalone Foundry v13 battle-map generator at `~/FoundryVTT/Data/modules/mapwright/`; procedural-vector, buildings-first, one-geometry-model design.
- [Blueprint News](blueprint-news.md) — engine-agnostic SLA BPN briefing generator at `~/blueprint-news/`; reusable component + standalone app, seeded procedural SVG art, Player/GM split, NPC seam for a separate module.
- [clipsync](clipsync.md) — CouchDB-backed clipboard history for the Macs; `clipsync-setup` to install, `clip` to browse.
- [AFTERIMAGE scenario](afterimage-scenario.md) — 4-player Blade Runner game for Continuum 2026, Fri 24 July, Slot 2; repo slaguru666/Continuum2026; convention-ready.
- [Plugin sync](project_plugin_sync.md) — keep Claude Code plugins identical across all servers via the claude-config repo (settings.json enabledPlugins); run sync.sh after install/remove
- [MINI-S remote access](infra_minis_remote_access.md) — timevans-MINI-S: static 192.168.1.6, key-only SSH + fail2ban, Zyxel DX3301-T0 port-forward 2222->22 (Voneus)
- [MINI-S Docker stacks](infra_minis_docker_stacks.md) — homelab (Portainer/Gitea/Obsidian/Stirling-PDF/Nextcloud) + Seafile cloud drive; ports, data paths, secrets locations
- [MINI-S browser automation](infra_minis_browser_automation.md) — Playwright MCP (headless Chromium) lets Claude view/control web pages on the LAN incl. the Zyxel router; restart Claude after adding to load tools
- [Local LLM agent stack](local-llm-agent-stack.md) — Hermes Agent + Ollama + Gemma 4 12B on the user's Mac; install gotchas (64K ctx, uv-managed Python 3.11)
- [NotebookLM CLI setup](notebooklm-cli-setup.md) — notebooklm-py on the Mac; pin --python 3.12 (else silent 0.1.1 downgrade), browser login, launchd auth-refresh keepalive
